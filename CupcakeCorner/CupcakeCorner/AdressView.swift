//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Vladimir on 18.12.2024.
//

import SwiftUI

struct AdressView: View {
    
    @Bindable var orderStore: OrderStore
    @Binding var path: NavigationPath
    
    private var checkoutIsDisabled: Bool {
        let address = orderStore.order.address
        return ![address.name, address.streetAddress, address.city, address.zip].allSatisfy(validateAddress)
    }
    
    var body: some View {
        Form {
            Section("Address info") {
                TextField("Name", text: $orderStore.order.address.name)
                TextField("Adress", text: $orderStore.order.address.streetAddress)
                TextField("City", text: $orderStore.order.address.city)
                TextField("zip", text: $orderStore.order.address.zip)
            }
            Section {
                NavigationLink("Checkout", value: ViewHierarchy.checkOutView)
                    .disabled(checkoutIsDisabled)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func validateAddress(entry: String) -> Bool {
        !entry.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
