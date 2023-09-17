//
//  ContentView.swift
//  Memorize
//
//  Created by Bohdan on 03.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFacedUp: true )
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.mint)
        .padding()
    }
}

struct CardView: View {
    var isFacedUp: Bool = false
    var body: some View {
        ZStack(content: {
            if isFacedUp {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 5)
                Text("🪼").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
