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
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                print("通知許可: \(granted), エラー: \(String(describing: error))")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            StartView()
        }
        .modelContainer(for: Item.self)
    }
}
