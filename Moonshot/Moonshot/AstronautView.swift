//
//  AstranautView.swift
//  Moonshot
//
//  Created by Vladimir on 04.12.2024.
//

import SwiftUI

struct AstronautView: View {
    
    var astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
                    .padding(.vertical)
            }
            .padding(.horizontal)
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts")
    return AstronautView(astronaut: astronauts["grissom"]!)
        .preferredColorScheme(.dark)
}
