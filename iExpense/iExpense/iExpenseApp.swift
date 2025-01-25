//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Vladimir on 29.11.2024.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
