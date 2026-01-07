from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from models import models
from schemas.event import BookEvent, BookEventResponse
from db.database import get_db
from utils.dependencies import get_current_user
from core.enum import UserRole, BookingStatus, EventStatus
from datetime import datetime, timezone

router = APIRouter(prefix="/book", tags=["book", "event"])

@router.post("/book-event", response_model=BookEventResponse, status_code=status.HTTP_201_CREATED)
def book_event(event: BookEvent ,db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    
    if current_user.role != UserRole.user:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only user can book the tickets"
        )
    
    if event.no_of_seats <= 0:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Number of seats must be greater than zero"
        )
    
    try:

        with db.begin():
    
            event_to_be_book = db.query(models.Event).filter(
                models.Event.id == event.event_id,
                models.Event.event_status == EventStatus.UPCOMING,
                models.Event.is_event_booking_paused == False
            ).with_for_update().first()

            if not event_to_be_book:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail="No event found"
                )
            
            available_seats = event_to_be_book.event_seats - event_to_be_book.booked_seats

            if event.no_of_seats > available_seats:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Not enough seats available"
                )
            
            booking = models.Booking(
                event_id = event_to_be_book.id,
                user_id = current_user.id,
                no_of_seats = event.no_of_seats,
                booking_status = BookingStatus.CONFIRMED,

            )

            event_to_be_book.booked_seats += event.no_of_seats

            db.add(booking)
  
        db.refresh(booking)
        return booking
    
    except SQLAlchemyError:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Booking failed"
        )