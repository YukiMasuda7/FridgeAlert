import SwiftData
import SwiftUI

struct StartView: View {
    @State private var isShowingAddSheet = false

    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            List {
                ForEach(items, id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text("Expires: \(item.expirationDate, format: Date.FormatStyle(date: .numeric, time: .omitted))")
                            .font(.subheadline)
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
    
    
}

#Preview {
    StartView()
        .modelContainer(for: Item.self, inMemory: true)
}
