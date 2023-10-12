//
//   EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Bohdan on 03.09.2023.
// ViewModel

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.themeName)
                    .font(.largeTitle)
                Spacer()
                Text("Score: \(viewModel.score)")
                    .font(.largeTitle)
            }
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            HStack {
                Button("Shuffle"){
                    viewModel.shuffle()
                }
                Button("New Game") {
                    viewModel.newGame()
                }
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            .foregroundColor(viewModel.themeColor)
            .padding(5)
        }
    }
    
    struct CardView: View {
        let card: MemoryGame<String>.Card
        
        init(_ card: MemoryGame<String>.Card) {
            self.card = card
        }
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(card.content)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                }
                .opacity(card.isFacedUp ? 1 : 0)
                base.fill().opacity(card.isFacedUp ? 0 : 1)
            }
            .opacity(card.isFacedUp || !card.isMatched ? 1 : 0)
        }
    }
    
    struct EmojiMemoryGameView_Previews: PreviewProvider {
        static var previews: some View {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
