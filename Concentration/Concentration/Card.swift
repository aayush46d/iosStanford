//
//  Card.swift
//  Concentration
//
//  Created by Aayush Srivastava on 5/3/18.
//  Copyright © 2018 Aayush Srivastava. All rights reserved.
//

import Foundation

struct Card{
    var isFaceUp = false
    var isMatched = false
    var id: Int
    
    static var cardId = 0
    static func getUniqueIdentifier() -> Int {
        cardId = cardId + 1
        return cardId
    }
    
    init() {
        self.id = Card.getUniqueIdentifier()
    }
}
