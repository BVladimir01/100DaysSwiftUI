//
//  Models.swift
//  CupcakeCorner
//
//  Created by Vladimir on 17.12.2024.
//

import SwiftUI

@Observable
class Order: Codable {

    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
//        case _specialOptionsEnables = "specialOptionsEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAdress = "streetAdress"
        case _city = "city"
        case _zip = "zip"
    }
    
    enum Types: String , CaseIterable, Codable {
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
    
    var name = ""
    var streetAdress = ""
    var city = ""
    var zip = ""
    
    var cost: Decimal {
        var total = Decimal.zero
        total += Decimal(quantity)*2
        if extraFrosting {
            total += Decimal(quantity)
        }
        if addSprinkles {
            total += Decimal(quantity)/2
        }
        return total
    }
}

