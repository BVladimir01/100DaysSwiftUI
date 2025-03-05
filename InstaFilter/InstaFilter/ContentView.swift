//
//  ContentView.swift
//  InstaFilter
//
//  Created by Vladimir on 28.02.2025.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var intensity = 0.5
    @State private var photoItem: PhotosPickerItem?
    
    @State private var currentFilter = CIFilter.sepiaTone()
    private var context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                PhotosPicker(selection: $photoItem) {
                    if let image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: photoItem, loadPhoto)
                Spacer()
                HStack {
                    Text("Intensity")
                    Slider(value: $intensity, in: 0...1)
                        .onChange(of: intensity, applyProcessing)
                }
                .padding(.vertical)
                HStack {
                    Button("Change filter", action: changeFilter)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
        }
    }
    
    private func changeFilter() {
        
    }
    
    private func loadPhoto() {
        Task {
            guard let imageData = try? await photoItem?.loadTransferable(type: Data.self) else { return }
            guard let beginImage = CIImage(data: imageData) else { return }
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    private func applyProcessing() {
        currentFilter.intensity = Float(intensity)
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
