from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session
from db.database import get_db
from models import models
from schemas.event import EventResponse
from core.enum import EventStatus

router = APIRouter(prefix="/public", tags=["public"])

@router.get("/all", response_model=list[EventResponse], status_code=status.HTTP_200_OK)
def get_all_events(db: Session = Depends(get_db), page: int = Query(1, ge=1), limit: int = Query(10, ge=1, le=50)):

    offset = (page - 1) * limit
    
    events = db.query(models.Event).filter(
        models.Event.event_status == EventStatus.UPCOMING,
        models.Event.is_event_booking_paused == False
    ).order_by(models.Event.event_datetime.asc()).offset(offset).limit(limit).all()

    return events

@router.get("/event-details/{id}", response_model=EventResponse, status_code=status.HTTP_200_OK)
def get_event_details(id: int, db: Session = Depends(get_db)):
    pass