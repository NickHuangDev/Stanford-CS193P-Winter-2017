//
//  ViewController.swift
//  Calculator
//
//  Created by 黃琮淵 on 2017/3/15.
//  Copyright © 2017年 nickhuangDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var calculatorBrain = CalculatorBrain()

    // MARK: - IBAction
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        // Handle "."
        if digit == "." {
            if userIsInTheMiddleOfTyping && display.text!.contains(".") {
                // contain "."
                return
            } else {
                display.text = "0."
                userIsInTheMiddleOfTyping = true
                return
            }
        }
        
        if userIsInTheMiddleOfTyping {
            let testCurrentlyInDisplay = display.text!
            display.text = testCurrentlyInDisplay + digit;
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            calculatorBrain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            calculatorBrain.performOperation(mathematicalSymbol)
        }
        if let result = calculatorBrain.result {
            displayValue = result
        }
        print(calculatorBrain.description);
    }
}

