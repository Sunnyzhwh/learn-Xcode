//
//  ViewController.swift
//  Game02
//
//  Created by Sunny on 2019/6/18.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
   
  
    @IBAction func resetclicked(_ sender: Any) {
        for index in visibleTouchButtons.indices {
            visibleTouchButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            visibleTouchButtons[index].setTitle("", for: UIButton.State.normal)
        }
        for index in game.cards.indices
        {
            game.cards[index].isFaceup = false
            game.cards[index].isMatched = false
        }
        cardCount = 0
        _ = game.cards.randomArray()
    }
    @IBOutlet private weak var countFlips: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var touchCardbuttons: [UIButton]!
    private lazy var game = Concentration(numOfPairsOfCards: numOfPairsOfCards)
    var numOfPairsOfCards : Int{
            return (visibleTouchButtons.count+1) / 2
    }

    private(set) var cardCount = 0 {
        didSet{
            updateFlipCountLabel()
        }
    }
    private var visibleTouchButtons: [UIButton]! {
        return touchCardbuttons?.filter{!$0.superview!.isHidden}
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    func updateFlipCountLabel() {
        let attributes:[NSAttributedString.Key:Any] = [
            .foregroundColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),
            .strokeWidth : 5.0
            ]
        let attributedString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ? "Flips\n\(cardCount)" : "Flips:\(cardCount)",
            attributes:attributes)
        countFlips.attributedText = attributedString
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        cardCount += 1

        if  let cardNUM = visibleTouchButtons.lastIndex(of: sender){
        
            game.choosecard(at: cardNUM)
            print("card number is \(cardNUM+1)")
            updateViewFromModel()
        }
    }
    private func updateViewFromModel() {
//        for index in 0..<visibleTouchButtons.count
        if visibleTouchButtons != nil{
            for index in visibleTouchButtons.indices
            {
                let button = visibleTouchButtons[index]
                let card = game.cards[index]
                if card.isFaceup{
                    button.setTitle(emoji(for: card), for: UIButton.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)            }
                else{
                    button.setTitle("", for: UIButton.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)          }
            }
        }
//        for index in visibleTouchButtons.indices{
//            let button = visibleTouchButtons[index]
//            let card = game.cards[index]
//            if card.isMatched{
//                button.setTitle("", for: UIButton.State.normal)
//                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
//            }
//        }
    }
//    private var myEmoji = ["🏀","⚽️","🎾","🎱","⚾️","🏐","🏆","🏵","🚇","🚔","🏍","🚑","🚦"]
    var theme: String? {
        didSet{
            myEmoji = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    private var myEmoji = "🏀⚽️🎾🎱⚾️🏐🏆🏵🚇🚔🏍🚑🚦"
//    var emoji = Dictionary<Int,String>()
    private var emoji = [Card:String]()
    private func emoji(for card: Card)->String{
        if emoji[card] == nil, myEmoji.count > 0{

//            emoji[card.identifier] = myEmoji[randomIndex]
            let randomStringIndex = myEmoji.index(myEmoji.startIndex, offsetBy: myEmoji.count.arc4random)
            
            emoji[card] = String(myEmoji.remove(at: randomStringIndex))
        }
//        if emoji[card.identifier] != nil{
//            return emoji[card.identifier]!
//        }else{
//        return "?"
//        }
        return emoji[card] ?? "?"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("\(numOfPairsOfCards)")
        // Do any additional setup after loading the view, typically from a nib.
//        for index in visibleTouchButtons.indices{
//            let button = visibleTouchButtons[index]
//            button.setTitle("\(index)", for: UIButton.State.normal)
//        }
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
