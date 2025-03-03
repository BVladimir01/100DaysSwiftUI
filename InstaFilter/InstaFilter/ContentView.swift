//
//  ContentView.swift
//  InstaFilter
//
//  Created by Vladimir on 28.02.2025.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?.resizable()
                .scaledToFit()
            ContentUnavailableView {
                Label("No snippets", systemImage: "swift")
            } description: {
                Text("Yep, there are none")
            } actions: {
                Button("Create") { }
                Button("Delete") { }
            }
        }
        .onAppear {
            image = Image(.nsx)
            let filter = CIFilter.crystallize()
            let amount = 1.0
            let context = CIContext()
            let inputImage = UIImage(resource: .nsx)
            let beginImage = CIImage(image: inputImage)
            filter.inputImage = beginImage
            let inputKeys = filter.inputKeys
            if inputKeys.contains(kCIInputIntensityKey) {
                filter.setValue(amount, forKey: kCIInputIntensityKey)
            }
            if inputKeys.contains(kCIInputRadiusKey) {
                filter.setValue(amount*20, forKey: kCIInputRadiusKey)
            }
            if inputKeys.contains(kCIInputScaleKey) {
                filter.setValue(amount*10, forKey: kCIInputScaleKey)
            }
            guard let outputImage = filter.outputImage else { return }
            guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    ContentView()
}
