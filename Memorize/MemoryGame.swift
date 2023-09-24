//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bohdan on 24.09.2023.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set)  var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int) {
        cards = []
        
        for _ in 0..<numberOfPairsOfCards {
            cards.append(Card(isFacedUp: false, isMatched: false, content: <#T##CardContent#>))
            cards.append(Card(isFacedUp: false, isMatched: false, content: <#T##CardContent#>))
        }
    }
    
    func choose(card: Card) {
        
    }
    struct Card {
        var isFacedUp = false
        var isMatched = false
        var content: CardContent
    }
}
