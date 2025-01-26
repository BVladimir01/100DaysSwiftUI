//
//  ContentView.swift
//  iExpense
//
//  Created by Vladimir on 29.11.2024.
//


import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Query(sort: \ExpenseItem.name) private var expenses: [ExpenseItem]
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddExpense = false
    @State private var sortOrder = SortDescriptor(\ExpenseItem.name)
    @State private var shownTypes: Set<ExpenseItem.ExpenseType> = Set(ExpenseItem.ExpenseType.allCases)
    
    var body: some View {
        NavigationStack {
            ExpensesView(sortOrder: [sortOrder], filteredTypes: shownTypes)
                .navigationTitle("iExpenses")
                .toolbar {
                    Menu("Sort order", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort order", selection: $sortOrder) {
                            Text("By name").tag(SortDescriptor(\ExpenseItem.name))
                            Text("By amount")
                                .tag(SortDescriptor(\ExpenseItem.amount))
                        }
                    }
                    Menu("Filter", systemImage: "line.3.horizontal.decrease") {
                        ForEach(ExpenseItem.ExpenseType.allCases) { expenseType in
                            Toggle(expenseType.rawValue,
                                   isOn: Binding(
                                    get: {shownTypes.contains(expenseType)},
                                    set: {isSelected in
                                        if isSelected {
                                            shownTypes.insert(expenseType)
                                        } else {
                                            shownTypes.remove(expenseType)
                                        }
                                    }
                                   )
                            )
                        }
                    }
                    Button("Add", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
                .navigationDestination(isPresented: $showingAddExpense) {
                    AddView()
                }
        }
    }
}



#Preview {
    ContentView()
}
