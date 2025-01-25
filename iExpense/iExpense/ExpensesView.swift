//
//  ExpensesView.swift
//  iExpense
//
//  Created by Vladimir on 25.01.2025.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    
    @Query private var expenses: [ExpenseItem]
    @Environment(\.modelContext) private var modelContext
    private var personalExpensesExist: Bool {
        !expenses.filter({$0.type == .personal}).isEmpty
    }
    private var businessExpensesExist: Bool {
        !expenses.filter({$0.type == .business}).isEmpty
    }
    typealias ExpenseType = ExpenseItem.ExpenseType
    
    var body: some View {
        switch (personalExpensesExist, businessExpensesExist) {
        case (false, false):
            List {
                
            }
        case (false, true):
            List{
                listSection(for: .business)
            }
        case (true, false):
            List{
                listSection(for: .personal)
            }
        case (true, true):
            List{
                listSection(for: .personal)
                listSection(for: .business)
            }
        }
    }
    
    private func listSection(for expenseType: ExpenseType) -> some View {
        Section(expenseType.rawValue.capitalized) {
            ForEach(expenses.filter({$0.type == expenseType})) { item in
                ExpenseItemView(item: item)
            }
            .onDelete(perform: removeItems)
        }
    }
    
    private func removeItems(at positions: IndexSet) {
        for index in positions {
            let deletedItem = expenses[index]
            modelContext.delete(deletedItem)
        }
    }
}


private extension ExpensesView {
    private struct ExpenseItemView: View {
        var item: ExpenseItem
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.type.rawValue)
                }
                Spacer()
                Text(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
                    .foregroundStyle(color(for: item.amount))
            }
        }
        
        private func color(for price: Double) -> Color {
            switch price {
            case ..<1000:
                    .green
            case 1000..<10_000:
                    .yellow
            case 10_000...:
                    .red
            default:
                fatalError("Unexpected value for price")
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: ExpenseItem.self, configurations: config)
        return ExpensesView()
            .modelContainer(modelContainer)
    } catch {
        return Text(error.localizedDescription)
    }
}
