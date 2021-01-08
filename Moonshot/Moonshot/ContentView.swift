//
//  ContentView.swift
//  Moonshot
//
//  Created by Effy Zhang on 1/7/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showCrewName = true
    var body: some View{
        NavigationView{
            List(missions){mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: self.astronauts)){
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        
                        if(self.showCrewName){
                            HStack{
                                ForEach(mission.crew, id: \.name) { crewMember in
                                    Text("\(crewMember.name)")
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                        }else{
                            Text(mission.formattedLaunchDate)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(self.showCrewName ? "Launch Date" : "Crew Names" ){self.showCrewName.toggle()})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
