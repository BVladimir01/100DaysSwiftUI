//
//  RatingView.swift
//  Bookworm
//
//  Created by Vladimir on 18.01.2025.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var maxRating = 5
    var onImage: Image = Image(systemName: "star.fill")
    var offImage: Image? = nil
    var onColor: Color = .yellow
    var offColor: Color = .gray
    var label = ""
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            ForEach(1..<(maxRating + 1), id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number <= rating ? onColor : offColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    private func image(for number: Int) -> Image {
        if number <= rating {
            return onImage
        } else {
            return offImage ?? onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
