//
//  ContentView.swift
//  BrianTrainingGame
//
//  Created by Effy Zhang on 11/21/20.
//

import SwiftUI
struct ContentView: View {
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var instruction = Bool.random()
    @State private var showAlert = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack{
            VStack{
                VStack {
                        Text("\(possibleMoves[currentChoice])")
                        Text(instruction ? "win" : "lose")
                        Text("Your score is \(score)")
                }
                HStack {
                    ForEach(0 ..< possibleMoves.count ){ number in
                        Button(action: {
                            self.buttonTapped(number)
                        }, label: {
                            Text(self.possibleMoves[number])
                        })
                    }
                }
            }
        }.alert(isPresented: $showAlert){
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
        }

        

    }
    func buttonTapped(_ number: Int) {
        if (instruction && number == (currentChoice+1)%3){
            score += 1
            scoreTitle = "Correct"
        }
        
        else if (!instruction && number == (currentChoice-1)%3){
            score += 1
            scoreTitle = "Correct"
        }
        else{
            scoreTitle = "Wrong"
        }
        showAlert = true
    }
    
    func askQuestion() {
        currentChoice = Int.random(in: 0...2)
        instruction = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
