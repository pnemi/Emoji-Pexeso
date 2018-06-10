//
//  ViewController.swift
//  Emoji Pexeso
//
//  Created by Petr Němeček on 05/06/2018.
//  Copyright © 2018 Petr Němeček. All rights reserved.
//

import UIKit

extension Array {
    mutating func shuffle()
    {
        for _ in 0..<count
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

class ViewController: UIViewController {
    
    // TODO: isHidden button
    
    // TODO: scaledFonts
    
    // TODO: splash image screen
    
    // TODO: unflipped card side image pattern

    private lazy var game = Concentration(numOfPairsOfCards: numOfPairsOfCards)
    
    var numOfPairsOfCards: Int {
         return cardButtons.count / 2
    }
    
    private let cardBGColor = #colorLiteral(red: 0.4372058414, green: 0.5491686375, blue: 0.9215686275, alpha: 1)
    private let cardFlippedBGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle as NSString
        ]
        let attributedString = NSAttributedString(string: "Flips \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    var emojiChoices = ["🎃", "🧟‍♀️", "👻", "😱", "👽", "🧛‍♂️"]
    
    var emoji = [Card:String]()
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardIndex = cardButtons.index(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        } else {
            print("Button was not found in cardButtons collection")
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = cardFlippedBGColor
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardBGColor
            }
        }
    }

}
