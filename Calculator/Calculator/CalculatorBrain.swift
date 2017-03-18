//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 黃琮淵 on 2017/3/18.
//  Copyright © 2017年 nickhuangDev. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    // MARK: - Public function
    mutating func performOperation(_ symbol: String) {
        switch symbol {
        case "e":
            accumulator = M_E
        case "π":
            accumulator = Double.pi
        case "√":
            accumulator = sqrt(accumulator!)
            
        default:
            break
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
}
