//
//  Card.swift
//  Game02
//
//  Created by Sunny on 2019/6/18.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import Foundation
struct Card: Hashable
{
    var hashValue: Int {return identifier}
    static func ==(lhs:Card,rhs:Card)->Bool{
        return lhs.identifier == rhs.identifier
    }
    var isFaceup = false
    var isMatched = false
    private var identifier:Int
    private static var identifierFactory = 0
    private static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
