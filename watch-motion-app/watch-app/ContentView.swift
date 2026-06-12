import SwiftUI

struct ContentView: View {
    @EnvironmentObject var motionManager: MotionDataManager

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("Watch Motion Data")
                    .font(.headline)

                Text(motionManager.status)
                    .font(.subheadline)
                    .foregroundColor(.green)

                Group {
                    motionValueView(title: "Accel X", value: motionManager.accelerometerX)
                    motionValueView(title: "Accel Y", value: motionManager.accelerometerY)
                    motionValueView(title: "Accel Z", value: motionManager.accelerometerZ)

                    motionValueView(title: "Gyro X", value: motionManager.gyroX)
                    motionValueView(title: "Gyro Y", value: motionManager.gyroY)
                    motionValueView(title: "Gyro Z", value: motionManager.gyroZ)

                    motionValueView(title: "Motion", value: motionManager.motionMagnitude)
                }

                Button(action: toggleUpdates) {
                    Text(motionManager.isUpdating ? "Stop" : "Start")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(BorderedProminentButtonStyle())

                Button(action: motionManager.sendCurrentData) {
                    Text("Send to MongoDB Backend")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(!motionManager.isUpdating)
            }
            .padding()
        }
    }

    private func toggleUpdates() {
        if motionManager.isUpdating {
            motionManager.stopUpdates()
        } else {
            motionManager.startUpdates()
        }
    }

    private func motionValueView(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
                .monospacedDigit()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(MotionDataManager())
    }
}
