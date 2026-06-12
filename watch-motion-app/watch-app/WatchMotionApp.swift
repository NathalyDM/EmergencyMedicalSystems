import SwiftUI

@main
struct WatchMotionApp: App {
    @StateObject private var motionManager = MotionDataManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(motionManager)
        }
    }
}
