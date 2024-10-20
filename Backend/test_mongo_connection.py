import os
from pymongo import MongoClient

# Replace this URL with the correct one if it's not coming from your environment variables
mongo_url = os.getenv('MONGO_URL', 'mongodb://afnan123:afnan123@localhost:27017/Mini_Project')

client = MongoClient(mongo_url)

try:
    # Test connection by listing databases
    db_list = client.list_database_names()
    print("Databases:", db_list)
    print("Connection successful!")
except Exception as e:
    print("Error connecting to MongoDB:", e)
