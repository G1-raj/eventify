from pydantic import BaseModel, EmailStr
from enum import Enum

class UserRole(str, Enum):
    user = "user"
    organizer = "organizer"

class UserCreate(BaseModel):
    email: EmailStr
    username: str
    full_name: str
    password: str
    profile_pic: str | None = None

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id: int
    email: EmailStr
    username: str
    full_name: str
    profile_pic: str | None
    role: UserRole

    class Config:
        from_attributes = True

class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"

class AuthResponse(BaseModel):
    user: UserResponse
    token: TokenResponse