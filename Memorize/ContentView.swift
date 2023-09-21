//
//  ContentView.swift
//  Memorize
//
//  Created by Bohdan on 03.09.2023.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🦕", "🪼", " 🐢", " 🦐", "🦀", "🐆", "🦙", "🦍", "🦘"]
    
    @State var cardCount: Int = 4
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/2, contentMode: .fit)
            }
            .foregroundColor(.mint)
        }
    }
    
    var cardCountAdjusters: some View {
        HStack{
            cardRemover
            Spacer()
            cardAdder
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
                .font(.largeTitle)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.fill.badge.plus")
    }
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.fill.badge.minus")
    }
}

struct CardView: View {
    @State var content: String
    @State var isFacedUp: Bool = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
                .opacity(isFacedUp ? 1 : 0)
                base.fill().opacity(isFacedUp ? 0 : 1)
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
