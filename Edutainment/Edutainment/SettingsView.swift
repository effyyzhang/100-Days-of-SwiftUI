//
//  SettingsView.swift
//  Edutainment
//
//  Created by Effy Zhang on 12/21/20.
//

import SwiftUI



struct SettingsView: View {
    @ObservedObject var settings: Settings
        @ObservedObject var settingsToggle: SettingsToggle
    
    func createQuestions(level: Int, quizCount: Int){
        settings.questions.removeAll()
        for _ in 0..<quizCount{
            let tableSize = (level+1)*3
            let firstNum = Int.random(in: 1..<tableSize+1)
            let secondNum = Int.random(in: 1..<tableSize+1)
            let questionText = String("\(firstNum) × \(secondNum)")
            let correctAnswer = String(firstNum*secondNum)
            let question = Question(text: questionText, answer: correctAnswer)
            settings.questions.append(question)
        }
    }
    
    var body: some View {
            NavigationView{
                VStack{
                    Form{
                        VStack{
                            Text("Level of Difficulty")
                                .font(.title2)
                                .frame(maxWidth:.infinity, alignment: .leading)
                            
                            Picker("Levels", selection: $settings.selectedLevelIdx){
                                ForEach(0..<settings.levels.count){
                                    Text("\(self.settings.levels[$0])")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .labelsHidden()
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                        
                        VStack{
                            Text("Number of Quiz")
                                .font(.title2)
                                .frame(maxWidth:.infinity, alignment: .leading)
                            
                            Stepper(value: $settings.selectedQuizCount, in: 5...20, step: 5){
                                Text("\(settings.selectedQuizCount)")
                            }
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                    }
                    
                    /*This button need more work*/
                    Button(action: {
                        createQuestions(level: settings.selectedLevelIdx, quizCount: settings.selectedQuizCount)
                        self.settingsToggle.isSettingsDisplayed.toggle()
                    }, label: {
                        Text("Start")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity, maxHeight: 56)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(8)
                            .padding(20)
                    }
                    )
                }

            }
        }
    }

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: Settings(), settingsToggle: SettingsToggle())
    }
}
