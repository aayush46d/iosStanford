//
//  ViewController.swift
//  Concentration
//
//  Created by Aayush Srivastava on 5/3/18.
//  Copyright © 2018 Aayush Srivastava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        get{
            return (cardButtons.count+1) / 2
        }
    }
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiList = ["🤡","😈","👽","💀","👹","💩","🖕🏻"]
    
    var emoji = [Int:String]()
    
    
    var flipcount = 0 {
        didSet {
            flipCountLabel.text = "Flips : \(flipcount)"
        }
    }

    @IBAction func touchCard(_ sender: UIButton) {
        flipcount = flipcount + 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("card not found")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojiList.count > 0 {
          emoji[card.id] = emojiList.remove(at: emojiList.count.arc4random)
        }
        
        return emoji[card.id] ?? "?"
    }

}

extension Int{
    var arc4random: Int{
        if self>0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self<0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}




