from fastapi import Request, Depends
from utils.rate_limiter import rate_limit
from models import models
from utils.dependencies import get_current_user

def login_rate_limit(request: Request):
    ip = request.client.host

    rate_limit(
        key=f"login:{ip}",
        limit=5,
        window_seconds=60
    )

def booking_rate_limit(current_user: models.User = Depends(get_current_user)):
    rate_limit(
        key=f"cancel:{current_user.id}",
        limit=5,
        window_seconds=60
    )

def cancel_booking_rate_limit(current_user: models.User = Depends(get_current_user)):
    rate_limit(
        key=f"cancel:{current_user.id}",
        limit=5,
        window_seconds=60
    )