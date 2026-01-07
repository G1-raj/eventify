from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from models import models
from schemas.event import BookEvent, BookEventResponse
from db.database import get_db
from utils.dependencies import get_current_user

router = APIRouter(prefix="/book", tags=["book", "event"])

@router.post("/book-event/{id}", response_model=BookEventResponse, status_code=status.HTTP_201_CREATED)
def book_event(id: int, db: Session = Depends(get_db), current_user: models.Event = get_current_user):
    pass