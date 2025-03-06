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
    @State private var beginImage: CIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false
    private var context = CIContext()
    
    @AppStorage("filtersCounter") private var filtersUsedCounter = 0
    private var filtersUsedThreshold = 5
    @Environment(\.requestReview) private var requestReview
    
    var body: some View {
        NavigationStack {
            vstackBody
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                filterOptions
            }
            .onChange(of: currentFilter, filterChanged)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if let image {
                        ShareLink(item: image, preview: SharePreview("InstaFilter picture", image: image))
                    } else {
                        Button("Share", systemImage: "square.and.arrow.up") { }
                            .disabled(true)
                    }
                }
            }
        }
    }
    
    private var vstackBody: some View {
        VStack {
            Spacer()
            photosPicker
            Spacer()
            intensitySlider
            .padding(.vertical)
            Button("Change filter") { showingFilters = true }
        }
    }
    
    private var photosPicker: some View {
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
    }
    
    private var intensitySlider: some View {
        HStack {
            Text("Intensity")
            Slider(value: $intensity, in: 0...1)
                .onChange(of: intensity, applyProcessing)
        }
    }
    
    @ViewBuilder private var filterOptions: some View {
        Button("Sepia") { currentFilter = .sepiaTone() }
        Button("Crystallize") { currentFilter = .crystallize() }
        Button("Blur") { currentFilter = .gaussianBlur() }
        Button("Pixellate") { currentFilter = .pixellate() }
        Button("Vignette") { currentFilter = .vignette() }
        Button ("Edges") { currentFilter = .edges() }
        Button("Unsharp mask") { currentFilter = .unsharpMask() }
        Button("Cancel", role: .cancel) { }
    }
    
    @MainActor private func filterChanged() {
        if let beginImage {
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
            filtersUsedCounter = (filtersUsedCounter + 1) % (filtersUsedThreshold + 1)
            if filtersUsedCounter == filtersUsedThreshold {
                requestReview()
            }
        }
    }
    
    private func loadPhoto() {
        Task {
            guard let imageData = try? await photoItem?.loadTransferable(type: Data.self) else { return }
            guard let beginImage = CIImage(data: imageData) else { return }
            self.beginImage = beginImage
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    private func applyProcessing() {
        let filterIntensity = Float(intensity)
        let keys = currentFilter.inputKeys
        if keys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if keys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity*100, forKey: kCIInputRadiusKey)}
        if keys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity*10, forKey: kCIInputScaleKey)}
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
