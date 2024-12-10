//
//  DetaiView.swift
//  Navigation
//
//  Created by Vladimir on 09.12.2024.
//

import SwiftUI

struct DetaiView: View {
    
    var number: Int
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in: 0..<100))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    path = NavigationPath()
                }
            }
    }
}

//#Preview {
//    DetaiView(number: 10)
//}
