//
//  Concentration.swift
//  Emoji Pexeso
//
//  Created by Petr Němeček on 05/06/2018.
//  Copyright © 2018 Petr Němeček. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var firstFaceUpCardIndex: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly

        }
        
        set {
            for cardIndex in cards.indices {
                cards[cardIndex].isFaceUp = (cardIndex == newValue)
            }
        }
    }
    
    init(numOfPairsOfCards: Int) {
        assert(numOfPairsOfCards > 0, "Concentration.init(at: \(numOfPairsOfCards): number of pairs of cards must be greater than zero")
        for _ in 1...numOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = firstFaceUpCardIndex, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                firstFaceUpCardIndex = index
            }
        }
    }
    
}
