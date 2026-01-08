from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from db.database import get_db
from core.enum import UserRole
from models import models
from utils.security import get_password, verify_password
from utils.jwt import create_access_token, create_refresh_token
from utils.rate_limiting_dependencies import login_rate_limit
from schemas.auth import UserCreate, UserLogin, UserResponse, AuthResponse


router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/signup", response_model = UserResponse, status_code = status.HTTP_201_CREATED, dependencies=[Depends(login_rate_limit)])
def signup(user: UserCreate, role: UserRole, db: Session = Depends(get_db)):

    existing_user = db.query(models.User).filter(models.User.email == user.email).first()

    if existing_user:
        raise HTTPException(
            status_code = status.HTTP_400_BAD_REQUEST,
            detail = "User already exist with provided email"
        )
    
    new_user = models.User(
        email = user.email,
        username= user.username,
        full_name = user.full_name,
        hashed_password = get_password(user.password),
        profile_pic = user.profile_pic,
        role = role
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return new_user

@router.post("/login", response_model=AuthResponse, dependencies=[Depends(login_rate_limit)])
def login(user: UserLogin, db: Session = Depends(get_db)):

    existing_user = db.query(models.User).filter(models.User.email == user.email).first()

    if not existing_user or not verify_password(user.password, existing_user.hashed_password):
        raise HTTPException(
            status_code = status.HTTP_400_BAD_REQUEST,
            detail = "Invalid credentials"
        )
    
    access_token = create_access_token(
        data = { "sub": str(existing_user.id), "role": existing_user.role }
    )

    refresh_token = create_refresh_token(
        data = { "sub": str(existing_user.id), "role": existing_user.role }
    )

    existing_user.hashed_refresh_token = get_password(refresh_token)
    db.commit()

    return {
        "user": existing_user,
        "token": {
            "access_token": access_token,
            "refresh_token": refresh_token
        }
    }