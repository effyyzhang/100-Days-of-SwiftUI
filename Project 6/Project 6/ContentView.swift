//
//  ContentView.swift
//  Project 6
//
//  Created by Effy Zhang on 11/26/20.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    var body: some View {

        HStack(spacing: 0){
            ForEach(0 ..< letters.count){ num in
                Text(String(self.letters[num]))
                    .padding(4)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .background( self.enabled ? Color.blue : Color.orange)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num)/50))
            }
        }
        .gesture(DragGesture()
                    .onChanged{self.dragAmount = $0.translation }
                    .onEnded{ _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                        
                    }
        )


        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
