//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Vladimir on 01.12.2024.
//

import SwiftData
import Foundation


@Model
class ExpenseItem {
    let name: String
    let amount: Double
    let type: ExpenseType
    
    enum ExpenseType: String, Codable, CaseIterable, Identifiable {
        case personal = "Personal", business = "Business"
        var id: Self { self }
    }
    
    init(name: String, amount: Double, type: ExpenseType) {
        self.name = name
        self.amount = amount
        self.type = type
    }
}
