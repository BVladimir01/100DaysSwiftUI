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
    
    var body: some View {
        NavigationStack {
            ExpensesView()
                .navigationTitle("iExpenses")
                .toolbar {
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
