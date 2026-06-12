# Watch Motion App

This folder contains a sample Apple Watch motion capture app with a MongoDB backend.

## Overview

- `backend/`: Node.js + Express API that stores motion readings in MongoDB.
- `watch-app/`: SwiftUI watchOS app source files to capture accelerometer and gyroscope readings.

## What it measures

- Accelerometer data
- Gyroscope data
- Device motion magnitude (computed from acceleration)

## Setup

### Backend

1. Open a terminal in `watch-motion-app/backend`
2. Copy `.env.example` to `.env`
3. Set `MONGODB_URI` to your MongoDB connection string
4. Run:

```powershell
npm install
npm start
```

### Watch App

1. Open Xcode and create a new watchOS app or watch app target.
2. Add the Swift files from `watch-app/` to your WatchKit Extension.
3. Set `backendURL` in `MotionDataManager.swift` to your backend address, for example:

```swift
let backendURL = "https://your-server.example.com/api/motion"
```

4. Build and run on a watch device or simulator.

## Notes

- Direct MongoDB connections from watchOS are not recommended. This example uses an HTTP API backend.
- Replace the backend URL with your server endpoint.
- For real Apple Watch deployments, use a physical watch and enable network access.
