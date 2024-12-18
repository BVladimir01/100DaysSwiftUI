//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Vladimir on 18.12.2024.
//

import SwiftUI

struct AdressView: View {
    
    @Bindable var order: Order
    
    private var checkoutIsDisabled: Bool {
        order.name.isEmpty || order.streetAdress.isEmpty || order.city.isEmpty || order.zip.isEmpty
    }
    
    var body: some View {
        Form {
            Section("Adress info") {
                TextField("Name", text: $order.name)
                TextField("Adress", text: $order.streetAdress)
                TextField("City", text: $order.city)
                TextField("zip", text: $order.zip)
            }
            Section {
                NavigationLink("Checkout") {
                    CheckView(order: order)
                }
                .disabled(checkoutIsDisabled)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
