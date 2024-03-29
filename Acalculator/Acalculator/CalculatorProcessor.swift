//
//  CalculatorProcessor.swift
//  Acalculator
//
//  Created by Sunny on 2019/9/21.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
class CalculatorProcessor {
    var automaticDecimal = false {
        didSet {
            if automaticDecimal {
                previousOperand = resetOperand()
                currentOperand = resetOperand()
            }
        }
    }
    var previousOperand: String = "0"
    var currentOperand: String = "0"
    var storedOperator: CalculatorKey?
    
    func storeOperand(_ value: Int) -> String {
        let operand = "\(value)"
        if currentOperand == "0" {
            currentOperand = operand
        } else {
            currentOperand += operand
        }
        if storedOperator == .equal {
            if automaticDecimal {
                currentOperand = previousOperand + operand
            } else {
                currentOperand = operand
            }
            storedOperator = nil
        }
        if automaticDecimal {
            currentOperand = currentOperand.replacingOccurrences(of: decimalSymbol(), with: "")
            if currentOperand[currentOperand.startIndex] == "0" {
                currentOperand.remove(at: currentOperand.startIndex)
            }
            let char = decimalSymbol()[decimalSymbol().startIndex]
            currentOperand.insert(char, at: currentOperand.index(currentOperand.endIndex, offsetBy: -2))
        }
        return currentOperand
    }
    
    func storeOperator(_ rawValue: Int) -> String {
        if storedOperator != nil && storedOperator != .equal {
            previousOperand = computeFinalValue()
        } else if storedOperator == .equal && rawValue == CalculatorKey.equal.rawValue {
            return currentOperand
        } else {
            previousOperand = currentOperand
        }
        currentOperand = resetOperand()
        storedOperator = CalculatorKey(rawValue: rawValue)!
        return previousOperand
    }
    
    func computeFinalValue() -> String {
        let value1 = (previousOperand as NSString).doubleValue
        let value2 = (currentOperand as NSString).doubleValue
        if let oper = storedOperator {
            var output = 0.0
            switch oper {
            case .multiply:
                output = value1 * value2
            case .divide:
                output = value1 / value2
            case .subtract:
                output = value1 - value2
            case .add:
                output = value1 + value2
            case .equal:
                return currentOperand
            default:
                break
            }
            currentOperand = formatValue(output)
        }
        previousOperand = resetOperand()
        storedOperator = .equal
        return currentOperand
    }
    
    private func resetOperand() -> String {
        var operand = "0"
        if automaticDecimal {
            operand = convertOperandToDecimals(operand)
        }
        return operand
    }
    func clearAll() -> String {
        storedOperator = nil
        currentOperand = resetOperand()
        previousOperand = resetOperand()
        return currentOperand
    }
    
    func addDecimal() -> String {
        if currentOperand.range(of: decimalSymbol()) == nil {
            currentOperand += decimalSymbol()
        }
        return currentOperand
    }
    
    func decimalSymbol() -> String {
        return "."
    }
    func convertOperandToDecimals(_ operand: String) -> String {
        return operand + ".00"
    }
    func formatValue(_ value: Double) -> String {
        var raw = "\(value)"
        if automaticDecimal {
            raw = String(format: "%.2f", value)
            return raw
        } else {
            var end = raw.index(before: raw.endIndex)
            var foundDecimal = false
            while end != raw.startIndex && (raw[end] == "0" || isDecimal(raw[end])) && !foundDecimal {
                foundDecimal = isDecimal(raw[end])
                raw.remove(at: end)
                end = raw.index(before: end)
            }
            return raw
        }
    }
    
    func isDecimal(_ char: Character) -> Bool {
        return String(char) == decimalSymbol()
    }
    
    func changeSign() -> String {
        if currentOperand[currentOperand.startIndex] == "-" {
            currentOperand.remove(at: currentOperand.startIndex)
        }else{
            currentOperand.insert("-", at: currentOperand.startIndex)
        }
        return currentOperand
    }
    
    func percentage() -> String {
        let ptd = Double(currentOperand)! / 100.0
        currentOperand = String(ptd)
        return currentOperand
    }
}
