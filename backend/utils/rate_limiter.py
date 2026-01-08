import time
from collections import defaultdict
from fastapi import HTTPException, status

RATE_LIMIT_STORE = defaultdict(list)

def rate_limit(key: str, limit: int, window_seconds: int):
    current_time = time.time()
    window_start = current_time - window_seconds

    RATE_LIMIT_STORE[key] = [
        ts for ts in RATE_LIMIT_STORE[key]
        if ts > window_start
    ]

    if len(RATE_LIMIT_STORE[key]) >= limit:
        raise HTTPException(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail="Too many requests, please try again later"
        )
    
    RATE_LIMIT_STORE[key].append(current_time)