//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 黃琮淵 on 2017/3/18.
//  Copyright © 2017年 nickhuangDev. All rights reserved.
//

import Foundation

func factorial(_ n: Double) -> Double {
    if n <= 0 {
        return 1
    }
    return n * factorial(n - 1)
}

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "%": Operation.unaryOperation({ $0 / 100 }),
        "x⁻¹": Operation.unaryOperation({ 1 / $0 }),
        "x²": Operation.unaryOperation({ pow($0, 2) }),
        "x³": Operation.unaryOperation({ pow($0, 3) }),
        "10ˣ": Operation.unaryOperation({ pow(10, $0) }),
        "eˣ": Operation.unaryOperation(exp),
        "x!": Operation.unaryOperation(factorial),
        "ln": Operation.unaryOperation(log),
        "log10": Operation.unaryOperation(log10),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "sinh": Operation.unaryOperation(sinh),
        "cosh": Operation.unaryOperation(cosh),
        "tanh": Operation.unaryOperation(tanh),
        "±": Operation.unaryOperation({ -$0 }),
        "xʸ": Operation.binaryOperation(pow),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "=": Operation.equals
    ]
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    // MARK: - Public function
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
                break
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    // MARK: - Private function
    mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
}
