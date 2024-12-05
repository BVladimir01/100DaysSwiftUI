//
//  MissionView.swift
//  Moonshot
//
//  Created by Vladimir on 04.12.2024.
//

import SwiftUI

struct MissionView: View {
    
    private(set) var mission: Mission
    private var crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("No such astranaut in file")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                formattedMissionImage
                    .padding(.vertical)
                launchDate
                missionDescription
                .padding(.horizontal)
                crewScrollView
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    private var formattedMissionImage: some View {
        Image(mission.imageString)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { width, axis in
                width * 0.6
            }
    }
    
    private var launchDate: some View {
        Text("Launch date: \(mission.formattedLaunchDate)")
            .font(.headline.bold())
    }
    
    private var divider: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
    
    private var missionDescription: some View {
        VStack(alignment: .leading) {
            divider
            Text("Mission Highlights")
                .font(.title.bold())
                .padding(.vertical)
            Text(mission.description)
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.lightBackground)
                .padding(.vertical)
            Text("Crew")
                .font(.title.bold())
                .padding(.vertical)
        }
    }
    
    private var crewScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { member in
                    NavigationLink {
                        AstronautView(astronaut: member.astronaut)
                    } label: {
                        crewMemberView(of: member)
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    private func crewMemberView(of member: CrewMember) -> some View {
        HStack {
            Image(member.astronaut.id)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { width, axis in
                    width * 0.3
                }
            //                                .frame(width: 104, height: 72)
                .clipShape(.circle)
                .overlay(
                    Circle()
                        .strokeBorder(.white.opacity(0.5), lineWidth: 2)
                )
            VStack(alignment: .leading) {
                Text(member.astronaut.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(member.role)
                    .foregroundStyle(.white.opacity(0.5))
                
            }
            .containerRelativeFrame(.horizontal) { width, axis in
                width * 0.3
            }
        }
    }
    
    private struct CrewMember {
        var role: String
        var astronaut: Astronaut
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts")
    return MissionView(mission: missions[0], astronauts: astronauts).preferredColorScheme(.dark)
}
