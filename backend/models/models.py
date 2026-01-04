from sqlalchemy import Column, DateTime, ForeignKey, Integer, String, Enum as SQLEnum
from sqlalchemy.orm import relationship
from datetime import datetime, timezone
from db.database import Base
from enum import Enum

class UserRole(str, Enum):
    user = "user"
    organizer = "organizer"


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
        default="user", 
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