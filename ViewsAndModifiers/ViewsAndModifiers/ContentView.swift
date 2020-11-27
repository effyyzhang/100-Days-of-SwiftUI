//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Effy Zhang on 11/15/20.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
    }
}

extension View {
    func header1() -> some View {
    self.modifier(Title())
    }
}


struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .header1()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
