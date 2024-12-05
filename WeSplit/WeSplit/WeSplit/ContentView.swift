//
//  ContentView.swift
//  WeSplit
//
//  Created by Vladimir on 10.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercent = 11
    private let tipPercentages = [0, 5, 10, 11, 13, 15, 20]
    
    @FocusState private var amountIsFocused: Bool
    
    private let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    private var totalPerPerson: Double {
        amount*(1 + Double(tipPercent)/100)/Double(numberOfPeople)
    }
    private var totalAmount: Double {
        amount*(1 + Double(tipPercent)/100)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                amountAndPeopleSection
                tipSection
                altTipSection
                totalPerPersonSection
                totalAmountSection
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused.toggle()
                    }
                }
            }
        }
    }
    
    private var amountAndPeopleSection: some View {
        Section {
            TextField("Amount", value: $amount, format: .currency(code: currencyCode))
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
            Picker("Number of people", selection: $numberOfPeople) {
                ForEach(1..<100, id: \.self) {
                    Text("\($0)")
                }
            }
        }
    }
    
    private var tipSection: some View {
        Section("Tip percent") {
            Picker("Tip percent", selection: $tipPercent) {
                ForEach(tipPercentages, id: \.self) {
                    Text($0, format: .percent)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    private var altTipSection: some View {
        Section("Tip percent") {
            Picker("Tip percent", selection: $tipPercent) {
                ForEach(0...100, id: \.self) {
                    Text($0, format: .percent)
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
    
    private var totalPerPersonSection: some View {
        Section("Total per person") {
            Text(totalPerPerson, format: .currency(code: currencyCode))
        }
    }
    
    private var totalAmountSection: some View {
        Section("Total amount with tip") {
            Text(totalAmount, format: .currency(code: currencyCode))
                .foregroundStyle(tipPercent == 0 ? .red : .primary)
        }
    }
}

#Preview {
    ContentView()
}
