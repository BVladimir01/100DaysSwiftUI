//
//  ContentView.swift
//  Animations
//
//  Created by Vladimir on 25.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var isEnabled = false
    
    let array = Array("Hello World!")
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isEnabled.toggle()
                }
            }
            .frame(width: 150, height: 100)
            .font(.largeTitle)
            .background(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
            .foregroundStyle(.white)
            .rotate(for: 40, from: .bottom)
            if isEnabled {
                Rectangle()
                    .frame(width: 75, height: 50)
                    .transition(.pivot)
            }
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let angle: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(angle), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        modifier(active: CornerRotateModifier(angle: -90, anchor: .topTrailing)
                 , identity: CornerRotateModifier(angle: 0, anchor: .topTrailing))
    }
}

extension View {
    func rotate(for angle: Double, from anchor: UnitPoint) -> some View {
        self.modifier(CornerRotateModifier(angle: angle, anchor: anchor))
    }
}

#Preview {
    ContentView()
}
