//
//  AddView.swift
//  iExpense
//
//  Created by Vladimir on 01.12.2024.
//

import SwiftData
import SwiftUI
//import Foundation

struct AddView: View {
    
    @Query private var expenses: [ExpenseItem]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var amount = 0.0
    @State private var name = ""
    @State private var category = ExpenseItem.ExpenseType.personal
    @State private var alertIsShown = false
    
    private let categories = ExpenseItem.ExpenseType.allCases
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .alert("Enter valid product name", isPresented: $alertIsShown) { }
                Picker("Category", selection: $category) {
                    ForEach(categories) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expenses")
            .toolbar {
                Button("Submit") {
                    guard name.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
                        alertIsShown = true
                        return
                    }
                    modelContext.insert(ExpenseItem(name: name, amount: amount, type: category))
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    AddView(expenses: Expenses())
//}
