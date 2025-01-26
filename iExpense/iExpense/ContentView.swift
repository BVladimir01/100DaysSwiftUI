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
    @State private var sortOrder =  SortDescriptor(\ExpenseItem.name)
    
    var body: some View {
        NavigationStack {
            ExpensesView(sortOrder: [sortOrder])
                .navigationTitle("iExpenses")
                .toolbar {
                    Button("Add", systemImage: "plus") {
                        showingAddExpense = true
                    }
                    Menu("Sort order", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort order", selection: $sortOrder) {
                            Text("By name").tag(SortDescriptor(\ExpenseItem.name))
                            Text("By amount")
                                .tag(SortDescriptor(\ExpenseItem.amount))
                        }
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
