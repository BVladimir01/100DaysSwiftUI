//
//  ContentView.swift
//  InstaFilter
//
//  Created by Vladimir on 28.02.2025.
//

import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    
    @State var images: [Image] = []
    @State var imagesChoice: [PhotosPickerItem] = []
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<images.count, id: \.self) { i in
                    images[i]
                        .resizable()
                        .scaledToFit()
                }
            }
            PhotosPicker(selection: $imagesChoice, maxSelectionCount: 3, matching: .images) {
                Label("Select photos", systemImage: "photo")
                    .font(.title)
            }
            .onChange(of: imagesChoice) {
                images.removeAll(keepingCapacity: true)
                Task {
                    for choice in imagesChoice {
                        if let image = try await choice.loadTransferable(type: Image.self) {
                            images.append(image)
                        }
                    }
                }
            }
//            .padding(.bottom)
            ShareLink(item: Image(.nsx), preview: SharePreview("Share nsx", image: Image(.nsx))) {
                Label("Share", systemImage: "square.and.arrow.up")
                    .font(.title)
                    .padding(.vertical)
            }
            Button("Review request") {
                requestReview()
            }
            .font(.title)
        }
    }
}

#Preview {
    ContentView()
}
