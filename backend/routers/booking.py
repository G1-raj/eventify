from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from models import models
from schemas.event import BookEvent, BookEventResponse, PaginatedBookedEventItem, CancelBookingResponse
from db.database import get_db
from utils.dependencies import get_current_user
from core.enum import UserRole, BookingStatus, EventStatus
from datetime import datetime, timezone

router = APIRouter(prefix="/book", tags=["book", "event"])

@router.get("/get-booked-events", response_model=PaginatedBookedEventItem, status_code=status.HTTP_200_OK)
def get_my_all_booked_events(
    db: Session = Depends(get_db), 
    current_user: models.User = Depends(get_current_user), 
    page: int = Query(1, ge=1), 
    limit: int = Query(10, ge=1, le=50)
):
    
    offset = (page - 1) * limit
    
    base_query = (
        db.query(models.Booking).join(models.Event)
        .filter(
            models.Booking.user_id == current_user.id,
            models.Booking.booking_status == BookingStatus.CONFIRMED
        )
        .order_by(models.Booking.created_at.desc())
    )

    bookings = (
        base_query
        .offset(offset)
        .limit(limit)
        .all()
    )

    total = base_query.count()

    data = [
        {
            "booking_id": booking.id,
            "no_of_seats": booking.no_of_seats,
            "booking_status": booking.booking_status,
            "event": booking.event
        }

        for booking in bookings
    ]

    return {
        "page": page,
        "limit": limit,
        "total": total,
        "data": data
    }

    



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
    

@router.patch("/cancel-booking/{id}", response_model=CancelBookingResponse, status_code=status.HTTP_200_OK)
def cancel_my_booking(id: int, db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):

    if current_user.role != UserRole.user:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only user can cancel booked events"
        )
    
    try:

        with db.begin():
            booking = (
                db.query(models.Booking)
                .filter(
                    models.Booking.id == id,
                    models.Booking.user_id == current_user.id,
                    models.Booking.booking_status == BookingStatus.CONFIRMED
                )
                .first()
            )

            if not booking:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail="Booking not fount or already cancelled"
                )
            
            event = (
                db.query(models.Event)
                .filter(
                    models.Event.id == booking.event_id
                )
                .with_for_update()
                .first()
            )

            event.booked_seats -= booking.no_of_seats

            if event.booked_seats < 0:
                raise HTTPException(
                    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                    detail="Seat count inconsistency detected"
                )
            
            booking.booking_status = BookingStatus.CANCELLED

            return {
                "booking_id": booking.id,
                "booking_status": booking.booking_status
            }
    except SQLAlchemyError:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to cancel booking"
        )


    