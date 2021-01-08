//
//  AstronautView.swift
//  Moonshot
//
//  Created by Effy Zhang on 1/7/21.
//

import SwiftUI

struct AstronautView: View {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronaut: Astronaut
    var participatedMissions = [Mission]()
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical){
                VStack{
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width)
                        .padding(.top)
                    
                    
                    Text(self.astronaut.description)
                        .padding(.horizontal)
                        .layoutPriority(1)
                    
                    ForEach(self.participatedMissions, id: \.id){mission in
                        HStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 56, height:56)
                            
                            VStack(alignment:.leading){
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                
                }
                
            }
        }
        .navigationBarTitle(self.astronaut.name, displayMode: .inline)
    }
    
    init (astronaut: Astronaut){
        self.astronaut = astronaut
        var matches = [Mission]()
        for mission in missions {
            //neeed some clarification
            if let _ = mission.crew.first(where: {$0.name == astronaut.id}){
                matches.append(mission)
            }
        }
        self.participatedMissions = matches
    }

}

struct AstronautView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
