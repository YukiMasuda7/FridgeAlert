import SwiftUI

enum ExpirationStatus {
    case expired
    case today
    case soon(Int)
    case normal(Int)

    var color: Color {
        switch self {
        case .expired: return .gray
        case .today: return .red
        case .soon: return .orange
        case .normal: return .green
        }
    }

    init(daysLeft: Int) {
        if daysLeft < 0 { self = .expired }
        else if daysLeft == 0 { self = .today }
        else if daysLeft <= 3 { self = .soon(daysLeft) }
        else { self = .normal(daysLeft) }
    }
}
