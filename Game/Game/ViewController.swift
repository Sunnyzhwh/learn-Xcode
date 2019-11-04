//
//  ViewController.swift
//  Game
//
//  Created by Sunny on 2019/6/18.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipcount: Int = 0{
        didSet {
            flipcounted.text = "Fliped \(flipcount)"
        }
    }
    
    @IBOutlet weak var flipcounted: UILabel!
    

    @IBOutlet var cardButtons: [UIButton]!
    
    var myEmoji = ["🍎","😓","🍔","🐶","🐳","⚽️"]
    
    
    @IBAction func touchcard(_ sender: UIButton) {
        flipcount += 1
        if let cardNum = cardButtons.lastIndex(of: sender){
            flipcard(withEmoji: myEmoji[cardNum], on: sender)
        print("card number \(cardNum)")
        }
        
    }
    func flipcard (withEmoji emoji:String, on button :UIButton ){
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    


}

