//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Vladimir on 17.12.2024.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    
    @State private var order = Order()
        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Cake type", selection: $order.type) {
                        ForEach(Order.Types.allCases, id: \.self) { cakeType in
                            Text(cakeType.rawValue)
                        }
                    }
//                    .pickerStyle(.segmented)
//                    .labelsHidden()
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Order exta options", isOn: $order.specialOptionsEnabled)
                    if order.specialOptionsEnabled {
                        Toggle("Extra frosting", isOn: $order.extraFrosting)
                        Toggle("AddSprinkles", isOn: $order.addSprinkles)
                    }
                    
                }
                Section {
                    NavigationLink("Delivery details") {
                        AdressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
