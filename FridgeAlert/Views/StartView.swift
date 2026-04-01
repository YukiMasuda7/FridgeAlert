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
                    ItemRow(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { isShowingAddSheet = true }) {
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
            for offset in offsets {
                modelContext.delete(items[offset])
            }
        }
    }
}

// Preview
#Preview {
    StartView()
        .modelContainer(for: Item.self, inMemory: true)
}
