//
//  ViewController.swift
//  Concentration
//
//  Created by Aayush Srivastava on 5/3/18.
//  Copyright © 2018 Aayush Srivastava. All rights reserved.
//

import UIKit
import Crashlytics

class ViewController: UIViewController {

    var game: Concentration!
    
    var numberOfPairsOfCards: Int{
        get{
            return (cardButtons.count+1) / 2
        }
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    private var themeEmojiList = [String]()
    private var themeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    private var backgroundThemeColor: UIColor!
    var emoji = [Int:String]()
    
    var score = 0 {
        didSet {
            if score < 0{
                flipCountLabel.text = "Score : \(score)"
            }else{
                flipCountLabel.text = "Score : \(score)"
            }
        }
    }
    
    //MARK: overriding functions
    
    override func viewDidLoad() {
        updateNewGameView()
    }

    //MARK: Action methods
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("card not found")
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
//        Crashlytics.sharedInstance().crash()
        score = 0

        let cards = game.cards
        for (index, card) in cards.enumerated(){
            if card.isFaceUp {
                cardButtons[index].setTitle("", for: UIControlState.normal)
            }
        }
        cardButtons = cardButtons.map({(button : UIButton) -> UIButton in
            button.isEnabled = true
            return button
        })
        updateNewGameView()
    }
    
    // MARK: Private functions
    private func updateNewGameView(){
        newGameButton.layer.borderWidth = 2.0
        newGameButton.layer.cornerRadius = 5.0
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        let currentThemeId = 3.arc4random
        switch currentThemeId {
        case 0:
            themeEmojiList = ["🤡","😈","👽","💀","👹","💩","🖕🏻","☠️","👻","🎃"]
            themeColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            backgroundThemeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case 1:
            themeEmojiList = ["🤤", "😴", "😑", "🤯", "🤪", "🤓", "😕", "😤", "🤩", "😝"]
            themeColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            backgroundThemeColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        default:
            themeEmojiList = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸"]
            themeColor = #colorLiteral(red: 0.1287704581, green: 1, blue: 0.1195366907, alpha: 1)
            backgroundThemeColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        }
        for button in cardButtons{
            button.backgroundColor = themeColor
            button.layer.cornerRadius = 10.0
        }
        view.backgroundColor = backgroundThemeColor
        newGameButton.layer.borderColor = themeColor.cgColor
        newGameButton.setTitleColor(themeColor, for: UIControlState.normal)
        flipCountLabel.textColor = themeColor
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                score = score - 1
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = backgroundThemeColor
                button.layer.borderWidth = 2.0
                button.layer.borderColor = themeColor.cgColor
            }
            else{
                button.setTitle("", for: UIControlState.normal)
                if card.isMatched{
                    score = score + 5
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    button.isEnabled = false
                }
                else{
                    button.backgroundColor = themeColor
                }
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, themeEmojiList.count > 0 {
            emoji[card.id] = themeEmojiList.remove(at: themeEmojiList.count.arc4random)
            print("Count ---> \(themeEmojiList.count)")
        }
        return emoji[card.id] ?? "?"
    }

}

// MARK: extensions
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




