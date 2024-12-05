//
//  ContentView.swift
//  Moonshot
//
//  Created by Vladimir on 02.12.2024.
//

import SwiftUI

struct ContentView: View {
    
    let astranauts: [String: Astronaut] = Bundle.main.decode("astronauts")
    let missions: [Mission] = Bundle.main.decode("missions")
    
    @State private var displayGrid = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Group {
                if displayGrid {
                    gridLayout
                } else {
                    listLayout
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                toolBarButton
            }
        }
    }
    
    private var toolBarButton: some View {
        Button {
            displayGrid.toggle()
        } label: {
            Image(systemName: displayGrid ? "list.bullet" : "circle.grid.3x3.fill")
                .font(.title2)
        }
    }
    
    // MARK: - List layout
    
    private var listLayout: some View {
        List(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astranauts)
            } label : {
                HStack {
                    formattedListDescription(for: mission)
                    Spacer()
                    formattedListImage(for: mission)
                        .padding(.horizontal)
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }
    
    private func formattedListDescription(for mission: Mission) -> some View {
        VStack {
            Text(mission.displayName)
                .font(.headline)
                .padding(.bottom, 5)
            Text(mission.formattedLaunchDate)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
        }
    }
    
    private func formattedListImage(for mission: Mission) -> some View {
        Image(mission.imageString)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { width, _ in
                width * 0.2
            }
    }
    
    // MARK: - Grid Layout
    
    private var gridLayout: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astranauts)
                    } label: {
                        badge(for: mission)
                            .padding()
                    }
                }
            }
        }
    }
    
    private func badge(for mission: Mission) -> some View {
        VStack {
            formattedBadgeImage(for: mission)
            formattedBadgeDescription(for: mission)
            .padding(.vertical, 5)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
            .stroke(.lightBackground)
        )
    }
    
    private func formattedBadgeImage(for mission: Mission) -> some View {
        Image(mission.imageString)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .padding()
    }
    
    private func formattedBadgeDescription(for mission: Mission) -> some View {
        VStack {
            Text(mission.displayName)
                .font(.headline)
                .foregroundStyle(.white)
            Text(mission.formattedLaunchDate)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
        }
    }
    
    
}

#Preview {
    ContentView()
}
