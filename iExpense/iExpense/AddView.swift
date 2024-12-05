//
//  AddView.swift
//  iExpense
//
//  Created by Vladimir on 01.12.2024.
//

import SwiftUI
//import Foundation

struct AddView: View {
    
    @State private var amount = 0.0
    @State private var name = ""
    @State private var category = ExpenseItem.ExpenseType.personal
    
    private let categories = ExpenseItem.ExpenseType.allCases
    
    var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    @State private var alertIsShown = false
    
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
                    expenses.items.append(ExpenseItem(name: name, amount: amount, type: category))
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    AddView(expenses: Expenses())
//}
