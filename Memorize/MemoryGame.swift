//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bohdan on 24.09.2023.
//
// Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
    }
    
    var indexOfOneAndOnlyFacedUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFacedUp }.only }
        set { cards.indices.forEach { cards[$0].isFacedUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFacedUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfOneAndOnlyFacedUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hasAlreadyBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasAlreadyBeenSeen {
                            score -= 1
                        }
                        cards[chosenIndex].hasAlreadyBeenSeen = true
                        cards[potentialMatchIndex].hasAlreadyBeenSeen = true
                    }
                } else {
                    indexOfOneAndOnlyFacedUpCard = chosenIndex
                }
                cards[chosenIndex].isFacedUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible  {
        var isFacedUp = false
        var isMatched = false
        var hasAlreadyBeenSeen = false
        var content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFacedUp ? "up" : "down")\(isMatched ? "matched" : "") \(hasAlreadyBeenSeen ? "Has been seen" : "Has not been seen")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
