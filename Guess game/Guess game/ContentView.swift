//
//  ContentView.swift
//  Guess game
//
//  Created by Effy Zhang on 11/15/20.
//

import SwiftUI

struct Flag: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: Color.white, radius: 2)
    }
}

extension View {
    func flagStyle() -> some View {
        self.modifier(Flag())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var rotateAmount = 0.0
    @State private var buttonOpacity = 1.0

    

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                
                ForEach(0 ..< 3){ number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .flagStyle()
                    }
                    .opacity(number == correctAnswer ? 1.0 : buttonOpacity)
                    .rotation3DEffect(
                        .degrees(number == correctAnswer ? rotateAmount : 0.0),
                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                    )
                    
                
                    
            }
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message:Text("Your score is \(score)"),
                  dismissButton:
                    .default(Text("Continue")){
                        self.askQuestion()
                    })
        }


    }
    
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            self.score += 1
            withAnimation {self.rotateAmount += 360}
            withAnimation {self.buttonOpacity -= 0.5}
        } else {
            scoreTitle = "Wrong, that is \(countries[number]) 's flag"
            
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        buttonOpacity = 1.0
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
