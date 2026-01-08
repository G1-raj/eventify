from fastapi import FastAPI
from db.database import engine, Base
from routers import auth, booking, events, public

app = FastAPI()

Base.metadata.create_all(bind=engine)

app.include_router(auth.router)
app.include_router(booking.router)
app.include_router(events.router)
app.include_router(public.router)