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
        case unaryOperation((Double) -> Double, (String) -> (String))
        case binaryOperation((Double, Double) -> Double, (String, String) -> (String))
        case equals
        case clean
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt, { "√(" + $0 + ")"}),
        "%": Operation.unaryOperation({ $0 / 100 }, { "(" + $0 + ")%"}),
        "x⁻¹": Operation.unaryOperation({ 1 / $0 }, { "(" + $0 + ")⁻¹"}),
        "x²": Operation.unaryOperation({ pow($0, 2) }, { "(" + $0 + ")²"}),
        "x³": Operation.unaryOperation({ pow($0, 3) }, { "(" + $0 + ")³"}),
        "10ˣ": Operation.unaryOperation({ pow(10, $0) }, { "10 ^ (" + $0 + ")"}),
        "eˣ": Operation.unaryOperation(exp, { "e ^ (" + $0 + ")"}),
        "x!": Operation.unaryOperation(factorial, { "(" + $0 + ")!"}),
        "ln": Operation.unaryOperation(log, { "ln(" + $0 + ")"}),
        "log10": Operation.unaryOperation(log10, { "log10(" + $0 + ")"}),
        "sin": Operation.unaryOperation(sin, { "sin(" + $0 + ")"}),
        "cos": Operation.unaryOperation(cos, { "cos(" + $0 + ")"}),
        "tan": Operation.unaryOperation(tan, { "tan(" + $0 + ")"}),
        "sinh": Operation.unaryOperation(sinh, { "sinh(" + $0 + ")"}),
        "cosh": Operation.unaryOperation(cosh, { "cosh(" + $0 + ")"}),
        "tanh": Operation.unaryOperation(tanh, { "tanh(" + $0 + ")"}),
        "±": Operation.unaryOperation({ -$0 }, { "-(" + $0 + ")"}),
        "xʸ": Operation.binaryOperation(pow, { $0 + "^" + $1}),
        "×": Operation.binaryOperation({ $0 * $1 }, { $0 + "×" + $1}),
        "÷": Operation.binaryOperation({ $0 / $1 }, { $0 + "÷" + $1}),
        "+": Operation.binaryOperation({ $0 + $1 }, { $0 + "+" + $1}),
        "-": Operation.binaryOperation({ $0 - $1 }, { $0 + "-" + $1}),
        "=": Operation.equals,
        "C": Operation.clean
    ]
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        let descriptionFunction: (String, String) -> String
        let firstDescriptionOperand: String
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
        func perform(with secondDescriptionOperand: String) -> String {
            return descriptionFunction(firstDescriptionOperand, secondDescriptionOperand)
        }
    }
    
    var resultIsPending: Bool {
        get {
            return pendingBinaryOperation != nil
        }
    }
    
    private var descriptionAccumulator: String = ""
    
    var description: String {
        get {
            if resultIsPending {
                if pendingBinaryOperation?.firstDescriptionOperand == descriptionAccumulator {
                    return pendingBinaryOperation!.perform(with: "")
                } else {
                    return pendingBinaryOperation!.perform(with: descriptionAccumulator)
                }
            } else {
                return descriptionAccumulator
            }
        }
    }
    
    // MARK: - Public function
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                descriptionAccumulator = symbol
                accumulator = value
            case .unaryOperation(let function, let descriptionFunction):
                if accumulator != nil {
                    descriptionAccumulator = descriptionFunction(descriptionAccumulator)
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function, let descriptionFuncation):
                if accumulator != nil {
                    performPendingBinaryOperation()
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!, descriptionFunction: descriptionFuncation, firstDescriptionOperand: descriptionAccumulator)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
                
            case .clean:
                accumulator = nil;
                pendingBinaryOperation = nil
                descriptionAccumulator = ""
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        descriptionAccumulator = String(format: "%g", operand)
    }
    
    // MARK: - Private function
    mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            descriptionAccumulator = (pendingBinaryOperation?.perform(with: descriptionAccumulator))!
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
}
