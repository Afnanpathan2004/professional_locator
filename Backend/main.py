from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class UserData(BaseModel):
    username: str
    password: str
    additional_field: str

@app.post("/submit")
async def submit_data(data: UserData):
    print(f"Received data: {data}")
    return {"message": "Data received successfully!", "username": data.username, "additional_field": data.additional_field}
