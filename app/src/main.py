
from fastapi import FastAPI, HTTPException
from motor.motor_asyncio import AsyncIOMotorClient
from pydantic import BaseModel
from datetime import datetime, timezone
import os

app = FastAPI(title="Ahoum Sessions API")

MONGO_URI = os.getenv(
    "MONGO_URI",
    "mongodb://localhost:27017"
)

client = AsyncIOMotorClient(MONGO_URI)
database = client["sessionsdb"]
sessions = database["sessions"]


class Session(BaseModel):
    title: str
    description: str = ""


@app.get("/health")
async def health():
    try:
        await client.admin.command("ping")
        return {"status": "UP", "database": "connected"}
    except Exception:
        raise HTTPException(
            status_code=503,
            detail="Database unavailable"
        )


@app.post("/sessions", status_code=201)
async def create_session(session: Session):
    data = session.model_dump()
    data["createdAt"] = datetime.now(timezone.utc)

    result = await sessions.insert_one(data)

    return {
        "id": str(result.inserted_id),
        **session.model_dump()
    }


@app.get("/sessions")
async def get_sessions():
    result = []

    async for session in sessions.find():
        session["id"] = str(session.pop("_id"))
        result.append(session)

    return result
