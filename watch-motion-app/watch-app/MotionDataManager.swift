import Foundation
import CoreMotion
import WatchKit

class MotionDataManager: ObservableObject {
    @Published var status = "Ready"
    @Published var isUpdating = false
    @Published var accelerometerX = "0.000"
    @Published var accelerometerY = "0.000"
    @Published var accelerometerZ = "0.000"
    @Published var gyroX = "0.000"
    @Published var gyroY = "0.000"
    @Published var gyroZ = "0.000"
    @Published var motionMagnitude = "0.000"

    private let motionManager = CMMotionManager()
    private let updateInterval = 0.1
    private let backendURL = URL(string: "http://127.0.0.1:3000/api/motion")!

    func startUpdates() {
        guard motionManager.isDeviceMotionAvailable else {
            status = "Device motion not available"
            return
        }

        motionManager.deviceMotionUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let self = self, let motion = motion else {
                self?.status = "Motion error: \(error?.localizedDescription ?? "unknown")"
                return
            }

            self.isUpdating = true
            self.status = "Capturing"
            self.publishMotion(motion)
        }
    }

    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
        isUpdating = false
        status = "Stopped"
    }

    func sendCurrentData() {
        guard let motion = motionManager.deviceMotion else {
            status = "No motion data available"
            return
        }

        let payload = MotionPayload(
            deviceId: WKInterfaceDevice.current().identifierForVendor?.uuidString ?? "watch-device",
            timestamp: ISO8601DateFormatter().string(from: Date()),
            accelerometer: SensorSample(x: motion.userAcceleration.x, y: motion.userAcceleration.y, z: motion.userAcceleration.z),
            gyroscope: SensorSample(x: motion.rotationRate.x, y: motion.rotationRate.y, z: motion.rotationRate.z),
            motionMagnitude: sqrt(pow(motion.userAcceleration.x, 2) + pow(motion.userAcceleration.y, 2) + pow(motion.userAcceleration.z, 2))
        )

        postMotion(payload)
    }

    private func publishMotion(_ motion: CMDeviceMotion) {
        let accel = motion.userAcceleration
        let gyro = motion.rotationRate
        let magnitude = sqrt(accel.x * accel.x + accel.y * accel.y + accel.z * accel.z)

        accelerometerX = String(format: "%.3f", accel.x)
        accelerometerY = String(format: "%.3f", accel.y)
        accelerometerZ = String(format: "%.3f", accel.z)
        gyroX = String(format: "%.3f", gyro.x)
        gyroY = String(format: "%.3f", gyro.y)
        gyroZ = String(format: "%.3f", gyro.z)
        motionMagnitude = String(format: "%.3f", magnitude)
    }

    private func postMotion(_ payload: MotionPayload) {
        var request = URLRequest(url: backendURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(payload)
        } catch {
            status = "Encode error: \(error.localizedDescription)"
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.status = "Send failed: \(error.localizedDescription)"
                    return
                }
                self?.status = "Sent motion data"
            }
        }
        task.resume()
    }
}

struct SensorSample: Codable {
    let x: Double
    let y: Double
    let z: Double
}

struct MotionPayload: Codable {
    let deviceId: String
    let timestamp: String
    let accelerometer: SensorSample
    let gyroscope: SensorSample
    let motionMagnitude: Double
}
