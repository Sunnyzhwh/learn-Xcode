//
//  Concentration.swift
//  Game02
//
//  Created by Sunny on 2019/6/18.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import Foundation

struct  Concentration
{
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard : Int?{
        get{
//            let faceUpCardIndices = cards.indices.filter{cards[$0].isFaceup}
            return cards.indices.filter{cards[$0].isFaceup}.oneAndOnly
//            var foundIndex : Int?
//            for index in cards.indices{
//                if cards[index].isFaceup{
//                    if foundIndex == nil{
//                        foundIndex = index
//                    }else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceup = (index == newValue)
            }
            
        }
    }
    
    
    mutating func choosecard(at index:Int) {
        assert(cards.indices.contains(index),"Concentration.choosecard(at:\(index)):chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // check if cards match
                
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceup = true
//                indexOfOneAndOnlyFaceUpCard = nil
            }else if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex == index{
                cards[index].isFaceup = false
            }else
            {
                // either no card or 2 cards are face up
//                for flipdownIndex in cards.indices{
//                    cards[flipdownIndex].isFaceup = false
//                }
//                cards[index].isFaceup = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    init(numOfPairsOfCards:Int) {
        assert(numOfPairsOfCards > 0,"Concentration init(\(numOfPairsOfCards): you must have 1 pair of cards")
        for _ in 1...numOfPairsOfCards{
            let card = Card()
            cards += [card,card]
//        let matchingcard = card
//            cards.append(matchingcard)
//            cards.append(card)
           
            
        }
        _ = cards.randomArray()
    }
    
}
extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
}
extension Array{
//    @discardableResult
    mutating func randomArray() -> Array {
        var list = self
        for index in list.indices {
            let newIndex = (list.count-index).arc4random + index
            if index != newIndex {
                list.swapAt(index, newIndex)
                print("\(index)","\(newIndex)")
                }
            }
        self = list
    return list
    }
    
}
