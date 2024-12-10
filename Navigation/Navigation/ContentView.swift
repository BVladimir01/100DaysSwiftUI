//
//  ContentView.swift
//  Navigation
//
//  Created by Vladimir on 09.12.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetaiView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { num in
                    DetaiView(number: num, path: $pathStore.path)
                }
        }
    }
}

#Preview {
    ContentView()
}
