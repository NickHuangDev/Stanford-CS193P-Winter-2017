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

    // MARK: - IBAction
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let testCurrentlyInDisplay = display.text!
            display.text = testCurrentlyInDisplay + digit;
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
    }
    

}

