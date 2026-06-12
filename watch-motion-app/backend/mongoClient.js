import { MongoClient } from "mongodb";
import dotenv from "dotenv";

dotenv.config();

const uri = process.env.MONGODB_URI;
const dbName = process.env.MONGODB_DB || "watch_motion";

if (!uri) {
  throw new Error("MONGODB_URI is required in .env");
}

const client = new MongoClient(uri);

let db;

export async function connectToMongo() {
  if (!db) {
    await client.connect();
    db = client.db(dbName);
  }
  return db;
}

export function motionCollection() {
  if (!db) {
    throw new Error("MongoDB client not initialized. Call connectToMongo() first.");
  }
  return db.collection("motion_readings");
}
