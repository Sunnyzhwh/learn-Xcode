//
//  ViewController.swift
//  Acalculator
//
//  Created by Sunny on 2019/9/21.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
enum CalculatorKey: Int {
    case zero = 1
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case clear
    case multiply
    case divide
    case subtract
    case add
    case equal
    case decimal
    case changesign
    case percent
}
class ViewController: UIViewController {
    var processor = CalculatorProcessor()

    @IBOutlet weak var result: UILabel!
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case (CalculatorKey.zero.rawValue)...(CalculatorKey.nine.rawValue):
            let output = processor.storeOperand(sender.tag-1)
            result.text = output
            print(output)
        case CalculatorKey.clear.rawValue:
            let output = processor.clearAll()
            result.text = output
            print(output)
        case (CalculatorKey.multiply.rawValue)...(CalculatorKey.add.rawValue):
            let output = processor.storeOperator(sender.tag)
            print(output)
        case CalculatorKey.equal.rawValue:
            let output = processor.computeFinalValue()
            result.text = output
            print(output)
        case CalculatorKey.decimal.rawValue:
            let output = processor.addDecimal()
            result.text = output
            print(output)
        case CalculatorKey.changesign.rawValue:
            let output = processor.changeSign()
            result.text = output
            print(output)
        case CalculatorKey.percent.rawValue:
            let output = processor.percentage()
            result.text = output
            print(output)
        default:
            break
        }
    }



}

