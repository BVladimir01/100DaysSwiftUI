//
//  ContentView.swift
//  BetterRest
//
//  Created by Vladimir on 18.11.2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeUp
    private static var defaultWakeUp: Date {
    var components = DateComponents(hour: 7)
        return Calendar.current.date(from: components) ?? Date.now
    }
    @State private var coffeeAmount = 0
    
    private var goToBed: Date {
        return calculateBedtime()
    }
    
    @State private var predictionFailed = false
    
    var body: some View {
        NavigationStack {
            Form {
                wakeUpSection
                sleepSection
                coffeSection
            }
            .navigationTitle("BetterRest")
            Text(alertTitle)
                .font(.title)
                .padding()
        }
    }
    
    private var wakeUpSection: some View {
        Section("When do you want to wake up?") {
            DatePicker("Wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
        }
    }
    
    private var sleepSection: some View {
        Section("Desired amount of sleep"){
            Stepper("\(sleepAmount.formatted(.number)) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        }
    }
    
    private var coffeSection: some View {
        Section("Desired amount of sleep"){
            Stepper("\(sleepAmount.formatted(.number)) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        }
    }
    
    private var alertTitle: String {
        predictionFailed ? "Sorry, there was a problem calculating your bedtime." : "Your ideal bedtime is \(goToBed.formatted(date: .omitted, time: .shortened))"
    }
    
    private func calculateBedtime() -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let sleepHours = Double(Calendar.current.component(.hour, from: wakeUp))
            let sleepMinutes = Double( Calendar.current.component(.minute, from: wakeUp))
            let sleepTime = try model.prediction(
                wake: sleepHours*3600 + sleepMinutes*60,
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)).actualSleep
            return wakeUp - sleepTime
        } catch {
            predictionFailed = true
        }
        return Date.now
    }
}

#Preview {
    ContentView()
}
