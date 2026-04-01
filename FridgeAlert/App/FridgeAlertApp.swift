import SwiftData
import SwiftUI

@main
struct FridgeAlertApp: App {
    var body: some Scene {
        WindowGroup {
            StartView()
        }
        .modelContainer(for: Item.self)
    }
}
