from pydantic import BaseModel, EmailStr
from core.enum import EventStatus, BookingStatus
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


class PaginatedEventResponse(BaseModel):
    page: int
    limit: int
    total: int
    data: List[EventResponse]


class BookEvent(BaseModel):
    event_id: int
    no_of_seats: int


class BookEventResponse(BaseModel):
    id: int
    event_name: str
    event_datetime: datetime
    no_of_seats: int
    booking_status: BookingStatus


class BookedEventItem(BaseModel):
    booking_id: int
    no_of_seats: int
    booking_status: BookingStatus
    event: EventResponse

class PaginatedBookedEventItem(BaseModel):
    page: int
    limit: int
    total: int
    data: List[BookedEventItem]