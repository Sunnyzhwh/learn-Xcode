//
//  PlayingcardDeck.swift
//  playingcard
//
//  Created by Sunny on 2019/6/24.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import Foundation
struct PlayingcardDeck {
    private(set) var cards = [Playingcard]()
    init() {
        for suit in Playingcard.Suit.all{
            for rank in Playingcard.Rank.all{
                cards.append(Playingcard(suit:suit,rank:rank))
            }
        }
    }
    mutating func draw() -> Playingcard? {
        if cards.count > 0{
            return cards.remove(at: cards.count.arc4random)
        }else{
            return nil
        }
    }
}
extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
