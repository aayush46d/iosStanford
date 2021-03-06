//
//  Concentration.swift
//  Concentration
//
//  Created by Aayush Srivastava on 5/3/18.
//  Copyright © 2018 Aayush Srivastava. All rights reserved.
//

import Foundation

class Concentration{
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else{
                       return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].id  == cards[index].id{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else{
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
        var totalCards =  cards.count-1
        for _ in 0...totalCards{
            let randIndex = Int(arc4random_uniform(UInt32(totalCards-1)))
            cards.swapAt(randIndex, totalCards)
            totalCards = totalCards-1
            if totalCards == 1{
                return
            }
        }
        
        // TODO: shuffle the cards
    }
}
