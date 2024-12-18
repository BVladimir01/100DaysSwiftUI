//
//  Models.swift
//  CupcakeCorner
//
//  Created by Vladimir on 17.12.2024.
//

import SwiftUI

@Observable
class Order {
    
    enum Types: String , CaseIterable {
        case strawberry = "Strawberry"
        case vanilla = "Vanilla"
        case chocolate = "Chocolate"
        case rainbow = "Rainbow"
    }
    
    var type: Types = .strawberry
    var quantity = 3
    
    var specialOptionsEnabled = false {
        didSet {
            if !specialOptionsEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
}

