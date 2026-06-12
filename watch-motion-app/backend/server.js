import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import { connectToMongo, motionCollection } from "./mongoClient.js";

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.json());

app.get("/", (req, res) => {
  res.json({ message: "Watch Motion API is running" });
});

app.post("/api/motion", async (req, res) => {
  try {
    const motionRecord = req.body;
    if (!motionRecord || !motionRecord.deviceId) {
      return res.status(400).json({ error: "Invalid motion payload" });
    }

    const db = await connectToMongo();
    const collection = motionCollection();

    await collection.insertOne({
      ...motionRecord,
      receivedAt: new Date(),
    });

    res.status(201).json({ status: "saved" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Unable to save motion data" });
  }
});

app.listen(port, () => {
  console.log(`Watch Motion backend listening on http://localhost:${port}`);
});
