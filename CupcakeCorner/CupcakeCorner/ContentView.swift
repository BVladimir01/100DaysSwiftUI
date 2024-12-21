//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Vladimir on 17.12.2024.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    
    @State private var orderStore = OrderStore()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    Picker("Cake type", selection: $orderStore.order.type) {
                        ForEach(Order.Types.allCases, id: \.self) { cakeType in
                            Text(cakeType.rawValue.capitalized)
                        }
                    }
                    Stepper("Number of cakes: \(orderStore.order.quantity)", value: $orderStore.order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Order exta options", isOn: $orderStore.order.specialOptionsEnabled)
                    if orderStore.order.specialOptionsEnabled {
                        Toggle("Extra frosting", isOn: $orderStore.order.extraFrosting)
                        Toggle("AddSprinkles", isOn: $orderStore.order.addSprinkles)
                    }
                    
                }
                Section {
                    NavigationLink("Delivery details", value: ViewHierarchy.adressView)
                }
            }
            .navigationTitle("Cupcake Corner")
            .navigationDestination(for: ViewHierarchy.self) { viewType in
                switch viewType {
                case .adressView:
                    AdressView(orderStore: orderStore, path: $path)
                case .checkOutView:
                    CheckView(orderStore: orderStore, path: $path)
                case .rootView:
                    Text("")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
