from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from db.database import get_db
from models import models
from schemas.event import EventCreate, EventResponse
from utils.dependencies import get_current_user
from core.enum import UserRole, EventStatus
from datetime import datetime, timezone

router = APIRouter(prefix="/event", tags=["events"])


#to create the event by event organizer
@router.post("/create", response_model=EventResponse, status_code=status.HTTP_201_CREATED)
def create_event(event: EventCreate, db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    
    if current_user.role != UserRole.organizer:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only organizer can create event"
        )
    
    if event.event_datetime <= datetime.now(timezone.utc):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Event time should be future time"
        )

    existing_event = db.query(models.Event).filter(
        models.Event.organizer_id == current_user.id,
        models.Event.event_name == event.event_name,
        models.Event.event_datetime == event.event_datetime
    ).first()

    if existing_event:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Event already exists"
        )

    new_event = models.Event(
        event_name = event.event_name,
        event_address = event.event_address,
        event_datetime = event.event_datetime,
        event_seats = event.event_seats,
        booked_seats = 0,
        seat_price = event.seat_price,
        event_status = EventStatus.UPCOMING,
        organizer_id = current_user.id
    )

    db.add(new_event)
    db.commit()
    db.refresh(new_event)

    return new_event

#to get the event created by organizer
@router.get("/my", response_model=list[EventResponse], status_code=status.HTTP_200_OK)
def get_my_event(db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    
    if current_user.role != UserRole.organizer:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Only organizer can fetch all his events"
        )
    
    events = db.query(models.Event).filter(models.Event.organizer_id == current_user.id).all()

    return events

@router.put("/update/{id}", response_model=EventResponse, status_code=status.HTTP_201_CREATED)
def update_event_details(id: int, event: EventCreate, db: Session = Depends(get_db)):
    pass

@router.delete("/delete/{id}", response_model=EventResponse, status_code=status.HTTP_201_CREATED)
def delete_event(id: int, db: Session = Depends(get_db)):
    pass