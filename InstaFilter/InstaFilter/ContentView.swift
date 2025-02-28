//
//  ContentView.swift
//  InstaFilter
//
//  Created by Vladimir on 28.02.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingDialog = false
    @State private var backgroundColor: Color = .white
    
    var body: some View {
        VStack {
            Button("Hello world!") {
                showingDialog.toggle()
            }
            .frame(width: 300, height: 200)
            .font(.largeTitle)
            .background(backgroundColor)
            .confirmationDialog("Change color", isPresented: $showingDialog) {
                Button("White") { backgroundColor = .white }
                Button("Red") { backgroundColor = .red }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("some message")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
