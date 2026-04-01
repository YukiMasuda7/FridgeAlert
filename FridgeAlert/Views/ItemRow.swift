import SwiftUI

struct ItemRow: View {
    let item: Item
    
    var body: some View {
        let status = ExpirationStatus(daysLeft: item.daysLeft)
        
        HStack {
            Image(systemName: "applelogo")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(status.color)
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                expirationText(for: status)
            }
            .padding(4)
        }
        .padding(.vertical, 4)
    }
    
    @ViewBuilder
    private func expirationText(for status: ExpirationStatus) -> some View {
        switch status {
        case .expired:
            Text("Expired")
                .foregroundColor(status.color)
                .font(.subheadline)
        case .today:
            Text("Expires today")
                .foregroundColor(status.color)
                .font(.subheadline)
        case .soon(let days), .normal(let days):
            Text("Expires in \(days) day\(days == 1 ? "" : "s")")
                .foregroundColor(status.color)
                .font(.subheadline)
        }
    }
}
