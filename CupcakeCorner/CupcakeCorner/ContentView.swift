//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Vladimir on 17.12.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results = [Result(trackId: 0, trackName: "trackName", collectionName: "collectionName")]
    @State private var email = ""
    @State private var username = ""
    
    private var disableForm: Bool {
        email.count < 5 || username.count < 5
    }
    
    var body: some View {
        
        Form {
            Section("user info") {
                TextField("username", text: $username)
                TextField("email", text: $email)
            }
            Button("Create account") {
                print("creating account")
            }
            .disabled(disableForm)
        }
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color.gray
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(let error):
                Text(error.localizedDescription)
            @unknown default:
                fatalError()
            }
        }
        .frame(width: 200, height: 200)
        List(results, id: \.trackId) { song in
            VStack(alignment: .leading) {
                Text(song.trackName)
                    .font(.headline)
                Text(song.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("invalid url")
            return
        }
        guard let (songsData, _) = try? await URLSession.shared.data(from: url) else {
            print("invalid data")
            return
        }
        guard let songs = try? JSONDecoder().decode(Response.self, from: songsData) else {
            print("could not decode")
            return
        }
        results = songs.results
    }
}

#Preview {
    ContentView()
}
