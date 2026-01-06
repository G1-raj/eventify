from pydantic import BaseModel, EmailStr
from core.enum import EventStatus
from typing import List
from datetime import datetime


class EventCreate(BaseModel):
    event_name: str
    event_address: str
    event_datetime: datetime
    event_seats: int
    # booked_seats: int
    # available_seats: int
    seat_price: float
    # event_status: EventStatus
    # isEventBookingPaused: bool
    # banner: List[str]

class EventResponse(BaseModel):
    id: int
    organizer_id: int
    event_name: str
    event_address: str
    event_datetime: datetime
    event_seats: int
    booked_seats: int
    available_seats: int
    seat_price: float
    event_status: EventStatus
    is_event_booking_paused: bool
    banner: List[str]



#User features