//
//  ViewController.swift
//  Bcalculator
//
//  Created by Sunny on 2019/9/25.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var userIsTyping = false
    @IBOutlet weak var display: UILabel!
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    @IBAction func number(_ sender: UIButton) {
        if userIsTyping {
            display.text! += sender.currentTitle!
        }else{
            display.text = sender.currentTitle!
            userIsTyping = true
        }
    }
    private var processor = CalculatorProcessor()
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            processor.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathmaticalSysbol = sender.currentTitle {
           processor.performOperation(mathmaticalSysbol)
        }
        if let result = processor.result {
            displayValue = result
        }
    }
    

}

