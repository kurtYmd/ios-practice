//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bohdan on 24.09.2023.
// View

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    init() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static var themes: Array<Theme> = [
        Theme(name: "Fruits", emojis: ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"], numberOfPairsOfCards: 6, color: "red"),
        Theme(name: "Jobs", emojis: ["🕵️‍♀️", "👮‍♂️", "👩‍🌾", "👩‍🏫", "👨‍🏭", "🧑‍💻", "👩‍✈️" ,"👩‍🚀"], numberOfPairsOfCards: 6, color: "blue"),
        Theme(name: "Bugs", emojis: ["🐌", "🐞", "🪲", "🐛", "🦋", "🪰", "🪳" ,"🕷️"], numberOfPairsOfCards: 6, color: "purple"),
        Theme(name: "Vehicles", emojis: ["🚗", "🚕", "🚙", "🏎️", "🚓", "🚒", "🚑" ,"🚜"], numberOfPairsOfCards: 6, color: "orange"),
        Theme(name: "Weather", emojis: ["🌨️", "🌩️", "⛈️", "🌧️", "🌦️", "🌤️", "☀️", "⛅️"], numberOfPairsOfCards: 6, color: "green"),
        Theme(name: "Hearts", emojis: ["🩷", "❤️", "🧡", "💛", "💚", "🩵", "💙" ,"💜"], numberOfPairsOfCards: 6, color: "yellow")
    ]
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    private var theme: Theme
    
    var themeColor: Color {
        switch theme.color {
        case "red":
            return .red
        case "blue":
            return .blue
        case "purple":
            return .purple
        case "orange":
            return .orange
        case "green":
            return .green
        case "yellow":
            return .yellow
        default:
            return .mint
        }
    }
    
    var score: Int {
        return model.score
    }
    
    var themeName: String {
        return theme.name
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func newGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        theme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func shuffle() {
        model.shuffle()
        print(cards)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
