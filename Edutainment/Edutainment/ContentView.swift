//
//  ContentView.swift
//  Edutainment
//
//  Created by Effy Zhang on 12/21/20.
//

import SwiftUI

class SettingsToggle: ObservableObject {
    @Published var isSettingsDisplayed = true
}

class Settings: ObservableObject {
    @Published var levels = ["Easy", "Hard", "Super"]
    @Published var selectedLevelIdx = 0
    @Published var selectedQuizCount = 10
    @Published var questions = [Question]()
}

struct ContentView: View {
    @ObservedObject var settings = Settings()
    @ObservedObject var settingsToggle = SettingsToggle()
    
    
    var body: some View {
        NavigationView{
                if (settingsToggle.isSettingsDisplayed){
                    SettingsView(settings: settings, settingsToggle: settingsToggle)
                    
                }else{
                    GameView(settings: settings, settingsToggle: settingsToggle)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
