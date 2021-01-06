//
//  GameView.swift
//  Edutainment
//
//  Created by Effy Zhang on 12/21/20.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var settings: Settings
    @ObservedObject var settingsToggle: SettingsToggle
    @State private var currentQuestion = 0
    @State private var answer = ""
    @State private var score = 0
    @State private var message = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/){
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                        Text("\(message)")
                            .frame(height: 56)
                        ProgressView("\(currentQuestion+1) of \(settings.selectedQuizCount)", value: Float(currentQuestion+1), total: Float(settings.selectedQuizCount))
                        
                        Text("\(settings.questions[currentQuestion].text) = ")
                            .font(.custom("Montserrat", size: 56))
                    }
                    TextField("Enter an your answer here", text: $answer)
                        .keyboardType(.numberPad)
                        .frame(height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style:.continuous))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        validedAnswer()
                    }, label: {
                        Text("Check")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity, maxHeight: 56)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(8)
                    })
                    .disabled(answer.isEmpty)
                }
            }
                
            }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Game End"), message: Text("You score is \(score)"), dismissButton: Alert.Button.default(Text("Confirm"), action: {
                self.showingAlert.toggle()
                settingsToggle.isSettingsDisplayed = true
                self.score = 0
                self.currentQuestion = 0
                self.message = ""
            }))
        })
        .navigationBarItems(
            leading:
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("x")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
        }),
            trailing:
                HStack{
                    Image("zap")
                        .renderingMode(.template)
                        .foregroundColor(.yellow)
                    Text("\(score)")
                        .foregroundColor(.yellow)
        })
        .padding(20)
    }
    
    func validedAnswer(){
        if (settings.questions[currentQuestion].answer == answer && currentQuestion+1 < settings.selectedQuizCount) {
            score += 1
            currentQuestion += 1
            message = "Good Job!"
        }
        else if (settings.questions[currentQuestion].answer == answer && currentQuestion+1 == settings.selectedQuizCount){
            score += 1
            message = "This is the last question"
            self.showingAlert.toggle()
        }
        else{
            message = "Try again."
        }
        answer = ""
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(settings: Settings(), settingsToggle: SettingsToggle())
    }
}
