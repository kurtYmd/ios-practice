//
//  ContentView.swift
//  Memorize
//
//  Created by Bohdan on 03.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let emojis = ["🦕", "🪼", " 🐢", " 🦐", "🦀", "🐆", "🦙"]
        var cardCount = 4
        HStack {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.mint)
        .padding()
    }
}

struct CardView: View {
    @State var content: String
    @State var isFacedUp: Bool = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFacedUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        } .onTapGesture {
            isFacedUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
