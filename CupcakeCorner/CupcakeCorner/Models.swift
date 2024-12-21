//
//  Models.swift
//  CupcakeCorner
//
//  Created by Vladimir on 17.12.2024.
//

import SwiftUI


struct Order: Codable {

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case quantity = "quantity"
        case extraFrosting = "extraFrosting"
        case addSprinkles = "addSprinkles"
        case address = "address"
        
    }
    
    enum Types: String , CaseIterable, Codable {
        case strawberry, vanilla, chocolate, rainbow
    }
    
    struct Address: Codable {
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
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
    
    var address = Address()
    
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

enum ViewHierarchy: Hashable {
    case rootView, adressView, checkOutView
}

@Observable
class OrderStore {
    
    var order: Order {
        didSet {
            save()
        }
    }
    
    init() {
        if let orderData = UserDefaults.standard.data(forKey: orderSaveKey) {
            if let loadedOrder = try? JSONDecoder().decode(Order.self, from: orderData) {
                order = loadedOrder
                return
            }
        }
        order = Order()
        if let addressData = UserDefaults.standard.data(forKey: orderAddressSaveKey) {
            if let loadedAddress = try? JSONDecoder().decode(Order.Address.self, from: addressData) {
                order.address = loadedAddress
            }
        }
    }
    
    
    private func save() {
        let encoder = JSONEncoder()
        guard let addressData = try? encoder.encode(order.address), let orderData = try? encoder.encode(order) else { return }
        UserDefaults.standard.set(addressData, forKey: orderAddressSaveKey)
        UserDefaults.standard.set(orderData, forKey: orderSaveKey)
    }
    
    func deleteOrderInfoExceptAddress() {
        UserDefaults.standard.removeObject(forKey: orderSaveKey)
    }
    
    private let orderAddressSaveKey = "addressSaveKey"
    private let orderSaveKey = "orderSaveKey"
}
