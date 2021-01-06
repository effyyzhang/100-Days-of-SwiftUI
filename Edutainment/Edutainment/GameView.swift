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
    @State private var currentQuestion: Int = 0
    @State private var answer = ""
    @State private var score = 0
    
//    func checkAnser(currentQuestion: Int, answer: String) -> Bool {
//        print ("hello world")
//        return true
////        settings.questions[currentQuestion].answer == answer ? true : false
//    }
    
    var body: some View {
        NavigationView{
            VStack{
                ProgressView("\(currentQuestion) of \(settings.selectedQuizCount)", value: Float(currentQuestion), total: Float(settings.selectedQuizCount))
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    Text("Your question is")
                    Text("\(settings.questions[currentQuestion].text)")
                        .font(.largeTitle)
                    Text("Your answer is")
                    TextField("Answer", text: $answer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                .frame(maxHeight: .infinity)
                Spacer()
                Button(action: {
                    print ("check answer")
                }, label: {
                    Text("Check")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, maxHeight: 56)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .background(Color.green)
                        
                })
                
            }
            
            
            
        }
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
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(settings: Settings(), settingsToggle: SettingsToggle())
    }
}
