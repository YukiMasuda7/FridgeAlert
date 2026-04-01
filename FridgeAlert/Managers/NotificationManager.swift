import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    func scheduleExpiryNotification(expirationDate: Date, itemName: String) {
        let content = UNMutableNotificationContent()
        content.title = "賞味期限のお知らせ"
        content.body = "\(itemName) の賞味期限です！"
        content.sound = .default

        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: expirationDate)
        dateComponents.hour = 10
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知スケジュール失敗: \(error.localizedDescription)")
            } else {
                print("通知をスケジュールしました")
            }
        }
    }
}
