//
//  ContentView.swift
//  Memorize
//
//  Created by Bohdan on 03.09.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis: Array<String> = []
    
    let vehicles = ["🚗", "🚕", "🚙", "🏎", "🚓", "🚐", "🛻", "🚗", "🚕", "🚙", "🏎", "🚓", "🚐", "🛻"]
    let fishes = ["🐡", "🐠", "🐟", "🐬", "🐳", "🐋", "🦈", "🐡", "🐠", "🐟", "🐬", "🐳", "🐋", "🦈"]
    let fruits = ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardThemes
        }
        .padding()
    }
    
        var cards: some View {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]){
                ForEach(0..<emojis.count, id: \.self) { index in
                    CardView(content: emojis[index])
                        .aspectRatio(1/2, contentMode: .fit)
                }
                .foregroundColor(.mint)
            }
        }
    
    func cardsThemeChanger(array: Array<String>, symbol: String, text: String) -> some View {
        Button(action: {
            emojis += array.shuffled()
        }, label: {
            VStack {
                Image(systemName: symbol)
                    .font(.largeTitle)
                    .imageScale(.large)
                Text(text)
                    .font(.headline)
            }
        })
    }
    
        var cardThemes: some View {
            HStack (spacing: 40){
                vehilceTheme
                fruitTheme
                fishTheme
            }
        }
    
    var vehilceTheme: some View {
        cardsThemeChanger(array: vehicles, symbol: "car", text: "Vechicles")
    }
    
    var fruitTheme: some View {
        cardsThemeChanger(array: fruits, symbol: "applelogo", text: "Fruits")
    }
    
    var fishTheme: some View {
        cardsThemeChanger(array: fishes, symbol: "fish", text: "Fishes")
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
}
