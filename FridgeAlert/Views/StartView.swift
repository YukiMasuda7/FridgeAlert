import SwiftData
import SwiftUI

struct StartView: View {
    @State private var isShowingAddSheet = false

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.expirationDate, order: .forward)
    private var items: [Item]

    var body: some View {
        NavigationStack {
            List {
                ForEach(items, id: \.id) { item in
                    let status = ExpirationStatus(for: item.expirationDate)
                    HStack {
                        Image(systemName: "apple.logo")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(status.color)
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("Expires: \(item.expirationDate, format: Date.FormatStyle(date: .numeric, time: .omitted))")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        isShowingAddSheet = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingAddSheet) {
            AddItemView()
                .environment(\.modelContext, modelContext)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }

    enum ExpirationStatus {
        case expired
        case today
        case soon
        case normal

        var color: Color {
            switch self {
            case .expired: return .gray
            case .today: return .red
            case .soon: return .orange
            case .normal: return .green
            }
        }

        init(for date: Date) {
            let calendar = Calendar.current
            let days = calendar.dateComponents(
                [.day],
                from: calendar.startOfDay(for: Date()),
                to: calendar.startOfDay(for: date)
            ).day ?? 0

            if days < 0 { self = .expired }
            else if days == 0 { self = .today }
            else if days <= 3 { self = .soon }
            else { self = .normal }
        }
    }
}

#Preview {
    StartView()
        .modelContainer(for: Item.self, inMemory: true)
}
