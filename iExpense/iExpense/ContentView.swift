//
//  ContentView.swift
//  iExpense
//
//  Created by Vladimir on 29.11.2024.
//


import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Query private var expenses: [ExpenseItem]
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddExpense = false
    
    typealias ExpenseType = ExpenseItem.ExpenseType
    
    var body: some View {
        NavigationStack {
            List{
                Section("Personal") {
                    ForEach(expenses.filter( { $0.type == ExpenseType.personal} )) { item in
                        expenseItemView(item: item)
                    }
                    .onDelete(perform: removeItems)
                }
                Section("Business") {
                    ForEach(expenses.filter( { $0.type == ExpenseType.business} )) { item in
                        expenseItemView(item: item)
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button("Add", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            //            .sheet(isPresented: $showingAddExpense) {
            //                AddView(expenses: expenses)
            //            }
            .navigationDestination(isPresented: $showingAddExpense) {
                AddView()
            }
        }
    }
    
    private func removeItems(at positions: IndexSet) {
        for index in positions {
            let deletedItem = expenses[index]
            modelContext.delete(deletedItem)
        }
    }
    
    private struct expenseItemView: View {
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
    ContentView()
}
