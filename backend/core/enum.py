from enum import Enum

class UserRole(str, Enum):
    user = "user"
    organizer = "organizer"

class EventStatus(str, Enum):
    UPCOMING = "UPCOMING"
    SOLD_OUT = "SOLD_OUT"
    COMPLETED = "COMPLETED"
    CANCELLED = "CANCELLED"