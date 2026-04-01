import SwiftData
import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name: String = ""
    @State private var expirationDate: Date = .init()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Food Name", text: $name)
                DatePicker("Expiration Date", selection: $expirationDate, displayedComponents: .date)
            }
            .navigationTitle("Add Food")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addItem()
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(name: name, expirationDate: expirationDate)
            modelContext.insert(newItem)
        }
        dismiss()
    }
}

#Preview {
    AddItemView()
}
