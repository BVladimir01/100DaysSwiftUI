//
//  ContentView.swift
//  Navigation
//
//  Created by Vladimir on 09.12.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Mint", value: Color.mint)
                NavigationLink("Pink", value: Color.pink)
                NavigationLink("Teal", value: Color.teal)
            }
            .navigationDestination(for: Color.self) { color in
                color
            }
            .navigationTitle("Colors")
        }
    }
}

#Preview {
    ContentView()
}
