import SwiftData
import SwiftUI
import UserNotifications

@main
struct FridgeAlertApp: App {
    let notificationDelegate = NotificationDelegate()

    init() {
        let delegate = notificationDelegate
        DispatchQueue.main.async {
            let center = UNUserNotificationCenter.current()
            center.delegate = delegate
            center.requestAuthorization(options: [.alert, .sound, .badge]) {_,_ in }
        }
    }

    var body: some Scene {
        WindowGroup {
            StartView()
        }
        .modelContainer(for: Item.self)
    }
}
