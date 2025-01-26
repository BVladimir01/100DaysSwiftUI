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
    private var expensesToShow: [ExpenseItem] {
        expenses.filter({filteredTypes.contains($0.type)})
    }
    @Environment(\.modelContext) private var modelContext
    private var filteredTypes: Set<ExpenseType>
    
    typealias ExpenseType = ExpenseItem.ExpenseType
    
    var body: some View {
        List {
            ForEach(expensesToShow) { item in
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
    
    init(sortOrder: [SortDescriptor<ExpenseItem>], filteredTypes: Set<ExpenseType> ) {
        _expenses = Query(sort: sortOrder)
        self.filteredTypes = filteredTypes
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
        return ExpensesView(sortOrder: [.init(\ExpenseItem.name)], filteredTypes: .init([.business, .personal]))
            .modelContainer(modelContainer)
    } catch {
        return Text(error.localizedDescription)
    }
}
