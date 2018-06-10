//
//  ViewController.swift
//  Emoji Pexeso
//
//  Created by Petr Němeček on 05/06/2018.
//  Copyright © 2018 Petr Němeček. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // TODO: isHidden button
    
    // TODO: scaledFonts
    
    // TODO: splash image screen
    
    // TODO: unflipped card side image pattern
    
    override func viewDidLoad() {
        startNewGame()
    }

    private lazy var game = Concentration(numOfPairsOfCards: numOfPairsOfCards)
    
    var numOfPairsOfCards: Int {
         return cardButtons.count / 2
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let theme = [
        "halloween" : ["🎃", "🧟‍♀️", "👻", "😱", "👽", "🧛‍♂️", "😈", "🕷"],
        "animals"   : ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
        "sports"    : ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱"],
        "food"      : ["🍏", "🍌", "🥑", "🍓", "🍑", "🍉", "🥥", "🥕"]
    ]
    
    private let cardBGColor = #colorLiteral(red: 0.9764705882, green: 0.337254902, blue: 0.1333333333, alpha: 1)
    private let cardFlippedBGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    @IBOutlet weak var navbar: UINavigationItem!
    
    @IBOutlet weak var newGameButton: UIBarButtonItem!
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let string = "Flips: \(flipCount)"
        
        let boldAttribute = UIFont.boldSystemFont(ofSize: flipCountLabel.font.pointSize)
        let boldRange = NSRange(location: string.count - String(flipCount).count, length: String(flipCount).count)
        
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: boldAttribute, range: boldRange)
        
        flipCountLabel.attributedText = attributedString
    }
    
    var emojiChoices: [String]!
    
    var emoji = [Card:String]()
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    func startNewGame() {
        flipCount = 0
        if let pickedTheme = theme.random {
            emojiChoices = pickedTheme.value
            game = Concentration(numOfPairsOfCards: numOfPairsOfCards)
            updateViewFromModel()
        }
    }
    
    @IBAction func touchNewGameButton(_ sender: UIBarButtonItem) {
        startNewGame()
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
                if card.isMatched {
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    button.isEnabled = false
                } else {
                    button.backgroundColor = cardBGColor
                    button.isEnabled = true
                }
            }
        }
    }

}
