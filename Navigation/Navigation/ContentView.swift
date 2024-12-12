//
//  ContentView.swift
//  Navigation
//
//  Created by Vladimir on 09.12.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var pathStore = PathStore()
    @State private var title = "List"
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetaiView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { num in
                    DetaiView(number: num, path: $pathStore.path)
                }
//            List(0..<100) {
//                Text("\($0)")
//            }
//            .navigationTitle($title)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(.blue, for: .navigationBar)
//            .toolbarColorScheme(.dark, for: .navigationBar)
//            .toolbar {
//                ToolbarItemGroup(placement: .confirmationAction) {
//                    button
//                    button
//                }
//                ToolbarItemGroup(placement: .secondaryAction) {
//                    button
//                    button
//                }
//            }
        }
    }
    
    private var button: some View {
        Button("somebutton") {
            
        }
    }
}

#Preview {
    ContentView()
}
