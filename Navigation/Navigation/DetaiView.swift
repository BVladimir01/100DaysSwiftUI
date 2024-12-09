//
//  DetaiView.swift
//  Navigation
//
//  Created by Vladimir on 09.12.2024.
//

import SwiftUI

struct DetaiView: View {
    var number: Int
    
    var body: some View {
        Text("View with number \(number)")
    }
    
    init(number: Int) {
        self.number = number
        print("creating View number \(number)")
    }
}

#Preview {
    DetaiView(number: 10)
}
