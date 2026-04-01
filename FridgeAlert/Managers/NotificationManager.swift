import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    func scheduleExpiryNotification(expirationDate: Date, itemName: String) {
        let content = UNMutableNotificationContent()
        content.title = "Expiration Date"
        content.body = "\(itemName) expires today"
        content.sound = .default

        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: expirationDate)
        dateComponents.hour = 10
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { _ in }
    }
}
