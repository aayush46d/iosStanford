//
//  Concentration.swift
//  Concentration
//
//  Created by Aayush Srivastava on 5/3/18.
//  Copyright © 2018 Aayush Srivastava. All rights reserved.
//

import Foundation

class Concentration{
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].id  == cards[index].id{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else{
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
    }
    }
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards{
        let card = Card()
        cards.append(card)
        cards.append(card)
        }
        
        // TODO: shuffle the cards
    }
}
