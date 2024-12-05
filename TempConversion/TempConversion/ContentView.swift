//
//  ContentView.swift
//  TempConversion
//
//  Created by Vladimir on 11.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    private enum tempOptions: String, CaseIterable, Identifiable, Hashable {
        case Kelvin, Celcius, Fahrenheit
        
        var id: Self {
            self
        }
    }
    
    @State private var inputTemp: Double?
    @State private var inputUnit: tempOptions = .Celcius
    @State private var outputUnit: tempOptions = .Kelvin
    
    private var KelvinTemp: Double? {
        if let inputTemp {
            switch inputUnit {
            case .Kelvin:
                return inputTemp
            case .Celcius:
                return inputTemp + 273
            case .Fahrenheit:
                return (inputTemp - 32)*5/9 + 273
            }
        } else {
            return nil
        }
    }
    
    private var outputTemp: Double? {
        if let KelvinTemp {
            switch outputUnit {
            case .Kelvin:
                return KelvinTemp
            case .Celcius:
                return KelvinTemp - 273
            case .Fahrenheit:
                return (KelvinTemp - 273)*9/5 + 32
            }
        } else {
            return nil
        }
    }
    
    @FocusState private var inputTempIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter temperature in \(inputUnit.rawValue) here", value: $inputTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputTempIsFocused)
                }
                
                Section("Input Unit") {
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(tempOptions.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output Unit") {
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(tempOptions.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Temperature in \(outputUnit.rawValue)") {
                    Text(outputTemp ?? 0, format: .number)
                }
            }
            .navigationTitle("TempConversion")
            .toolbar {
                if inputTempIsFocused {
                    Button("Done") {
                        inputTempIsFocused.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
