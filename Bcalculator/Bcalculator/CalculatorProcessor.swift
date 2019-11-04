//
//  CalculatorProcessor.swift
//  Bcalculator
//
//  Created by Sunny on 2019/9/25.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import Foundation
func clear(double:Double) -> Double{
    return 0
}
func decimal(double:Double) -> Double{
    return 0.0
}
struct CalculatorProcessor {
    private var accumulator: Double?
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    private var operations: Dictionary<String,Operation> =
        [
        "𝝿": Operation.constant(Double.pi),
        "√": Operation.unaryOperation(sqrt),
        "±": Operation.unaryOperation({ -$0 }),
        "C": Operation.unaryOperation(clear),
        ".": Operation.unaryOperation(decimal),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "−": Operation.binaryOperation({ $0 - $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "=": Operation.equals
        ]
    mutating func performOperation(_ sysbol: String) {
        if let operation = operations[sysbol]{
            switch operation{
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    private var pendingBinaryOperation: PendingBinaryOperation?
    private struct PendingBinaryOperation{
        let function: (Double,Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
             return function(firstOperand, secondOperand)
        }
    }
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    var result: Double? {
        get{
            return accumulator
        }
    }
}
