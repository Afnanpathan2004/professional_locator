from pydantic import BaseModel
from datetime import datetime 


# User schema for creating a new user
class UserCreate(BaseModel):
    username: str
    password: str
    dob: str
    profession: str
    address: str
    pincode: str
    contact_number: str
    email: str
    latitude : str
    longitude : str


# User schema for the token response
class Token(BaseModel):
    access_token: str
    token_type: str
    refresh_token: str

# Schema for token data (for validating and decoding tokens)
class TokenData(BaseModel):
    username: str | None = None

# Schema for the community messages
class Message(BaseModel):
    message: str

# Schema for storing 1-1 chat messages
class MessageSchema(BaseModel):
    sender: str          
    receiver: str        
    message: str         
    timestamp: datetime 

