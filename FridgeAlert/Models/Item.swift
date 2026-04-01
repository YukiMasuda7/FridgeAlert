import Foundation
import SwiftData

@Model
final class Item: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var expirationDate: Date
    var createdAt: Date = Date()

    init(name: String, expirationDate: Date) {
        self.name = name
        self.expirationDate = expirationDate
    }
}
