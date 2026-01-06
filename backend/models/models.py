from sqlalchemy import Boolean, Column, DateTime, ForeignKey, Float, Integer, JSON, String, Enum as SQLEnum
from sqlalchemy.orm import relationship
from datetime import datetime, timezone
from db.database import Base
from core.enum import UserRole, EventStatus, BookingStatus



class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    email = Column(String, unique=True, nullable=False)
    username = Column(String, nullable=False)
    full_name = Column(String, nullable=False)
    hashed_password = Column(String, nullable=False)
    profile_pic = Column(String, nullable=True)
    hashed_refresh_token = Column(String, nullable=True)
    role = Column(
        SQLEnum(UserRole), 
        default=UserRole.user, 
        nullable=False
    )

    created_at = Column(
        DateTime(timezone=True),
        default= lambda: datetime.now(timezone.utc)
    )

    updated_at = Column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        onupdate=lambda: datetime.now(timezone.utc)
    )

    events = relationship("Event", back_populates="owner", cascade="all, delete-orphan")
    bookings = relationship("Booking", back_populates="owner", cascade="all, delete-orphan")


class Event(Base):
    __tablename__ = "events"

    id = Column(Integer, primary_key = True, index=True)
    event_name = Column(String, nullable = False)
    event_address = Column(String, nullable = False)
    event_datetime = Column(DateTime(timezone=True), nullable=False)
    event_seats = Column(Integer, nullable=False)
    booked_seats = Column(Integer, nullable=False, default=0)
    seat_price = Column(Float, nullable=False)
    event_status = Column(SQLEnum(EventStatus), nullable=False, default=EventStatus.UPCOMING)
    is_event_booking_paused = Column(Boolean, nullable=False, default=False)
    banner = Column(JSON,nullable=True)
    organizer_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    owner = relationship("User", back_populates="events")
    bookings = relationship("Booking", back_populates="event", cascade="all, delete-orphan")

    created_at = Column(
        DateTime(timezone=True),
        default= lambda: datetime.now(timezone.utc)
    )

    updated_at = Column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        onupdate=lambda: datetime.now(timezone.utc)
    )

class Booking(Base):
    __tablename__ = "bookings"

    id = Column(Integer, primary_key=True)
    no_of_seats = Column(Integer, nullable=False, default=1)
    booking_status = Column(SQLEnum(BookingStatus), nullable=False, default=BookingStatus.CONFIRMED)

    event_id = Column(Integer, ForeignKey("events.id"), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)

    owner = relationship("User", back_populates="bookings")
    event = relationship("Event", back_populates="bookings")
    created_at = Column(
        DateTime(timezone=True),
        default= lambda: datetime.now(timezone.utc)
    )

    updated_at = Column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        onupdate=lambda: datetime.now(timezone.utc)
    )