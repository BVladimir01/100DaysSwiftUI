//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Vladimir on 01.12.2024.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let amount: Double
    let type: ExpenseType
    
    enum ExpenseType: String, Codable, CaseIterable, Identifiable {
        case personal = "Personal", business = "Business"
        var id: Self { self }
    }
}

@Observable
class Expenses {
    
    var items: [ExpenseItem] {
        didSet {
            if let itemsData = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(itemsData, forKey: "expenseItems")
            }
        }
    }
    
    init() {
        let defaultItems = [ExpenseItem]()
        guard let itemsData = UserDefaults.standard.data(forKey: "expenseItems") else {
            items = defaultItems
            return
        }
        guard let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: itemsData) else {
            items = defaultItems
            return
        }
        items = decodedItems
    }
}
