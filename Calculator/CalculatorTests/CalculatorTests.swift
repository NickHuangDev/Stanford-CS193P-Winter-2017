//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by 黃琮淵 on 2017/3/15.
//  Copyright © 2017年 nickhuangDev. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDescription() {
        var calculatorBrain: CalculatorBrain = CalculatorBrain()
        // a. touching 7 + would show “7 + ...” (with 7 still in the display)
        calculatorBrain.setOperand(7)
        calculatorBrain.performOperation("+")
        XCTAssertTrue(calculatorBrain.resultIsPending, "result is not pending")
        XCTAssertEqual(calculatorBrain.description, "7+", "Description is not equal to 7+")
        
        // b. 7 + 9 would show “7 + ...” (9 in the display)
        // calculatorBrain.setOperand(9) // User click button but not to set model
        XCTAssertTrue(calculatorBrain.resultIsPending, "7 + ... result is not pending")
        XCTAssertEqual(calculatorBrain.description, "7+", "Description is not equal to 7+")
        
        // c. 7 + 9 = would show “7 + 9 =” (16 in the display)
        calculatorBrain.setOperand(9)
        calculatorBrain.performOperation("=")
        XCTAssertTrue(!calculatorBrain.resultIsPending, "result is pending")
        XCTAssertEqual(calculatorBrain.description, "7+9", "Description is not equal to 7+9")
        
        // d. 7 + 9 = √ would show “√(7 + 9) =” (4 in the display)
        calculatorBrain.performOperation("√")
        XCTAssertTrue(!calculatorBrain.resultIsPending, "result is pending")
        XCTAssertEqual(calculatorBrain.description, "√(7+9)", "Description is not equal to √(7+9)")
        
        // e. 7 + 9 = √ + 2 = would show “√(7 + 9) + 2 =” (6 in the display)
        calculatorBrain.performOperation("+")
        calculatorBrain.setOperand(2)
        calculatorBrain.performOperation("=")
        XCTAssertTrue(!calculatorBrain.resultIsPending, "result is pending")
        XCTAssertEqual(calculatorBrain.description, "√(7+9)+2", "Description is not equal to √(7+9)+2")
        
        // f. 7 + 9 √ would show “7 + √(9) ...” (3 in the display)
        calculatorBrain.setOperand(7)
        calculatorBrain.performOperation("+")
        calculatorBrain.setOperand(9)
        calculatorBrain.performOperation("√")
        XCTAssertTrue(calculatorBrain.resultIsPending, "result is not pending")
        XCTAssertEqual(calculatorBrain.description, "7+√(9)", "Description is not equal to 7+√(9)")
        
        // g. 7 + 9 √ = would show “7 + √(9) =“ (10 in the display)
        calculatorBrain.performOperation("=")
        XCTAssertTrue(!calculatorBrain.resultIsPending, "result is pending")
        XCTAssertEqual(calculatorBrain.description, "7+√(9)", "Description is not equal to 7+√(9)")
        
        // h. 7 + 9 = + 6 = + 3 = would show “7 + 9 + 6 + 3 =” (25 in the display)
        calculatorBrain.setOperand(7)
        calculatorBrain.performOperation("+")
        calculatorBrain.setOperand(9)
        calculatorBrain.performOperation("=")
        calculatorBrain.performOperation("+")
        calculatorBrain.setOperand(6)
        calculatorBrain.performOperation("=")
        calculatorBrain.performOperation("+")
        calculatorBrain.setOperand(3)
        calculatorBrain.performOperation("=")
        XCTAssertTrue(!calculatorBrain.resultIsPending, "result is pending")
        XCTAssertEqual(calculatorBrain.description, "7+9+6+3", "Description is not equal to 7+9+6+3")
        
        // i. 7 + 9 = √ 6 + 3 = would show “6 + 3 =” (9 in the display)
        calculatorBrain.setOperand(7)
        calculatorBrain.performOperation("+")
        calculatorBrain.setOperand(9)
        calculatorBrain.performOperation("=")
        calculatorBrain.performOperation("√")
        calculatorBrain.setOperand(6)
        calculatorBrain.performOperation("+")
        calculatorBrain.setOperand(3)
        calculatorBrain.performOperation("=")
        XCTAssertTrue(!calculatorBrain.resultIsPending, "result is pending")
        XCTAssertEqual(calculatorBrain.description, "6+3", "Description is not equal to 6+3")
        
        // j. 5 + 6 = 7 3 would show “5 + 6 =” (73 in the display)
        calculatorBrain.setOperand(5)
        calculatorBrain.performOperation("+")
        calculatorBrain.setOperand(6)
        calculatorBrain.performOperation("=")
        //calculatorBrain.setOperand(7) // User click button but not to set model
        //calculatorBrain.setOperand(3) // User click button but not to set model
        XCTAssertTrue(!calculatorBrain.resultIsPending, "result is pending")
        XCTAssertEqual(calculatorBrain.description, "5+6", "Description is not equal to 5+6")
        
        // k. 4 × π = would show “4 × π =“ (12.5663706143592 in the display)
        calculatorBrain.setOperand(4)
        calculatorBrain.performOperation("×")
        calculatorBrain.performOperation("π")
        calculatorBrain.performOperation("=")
        XCTAssertTrue(!calculatorBrain.resultIsPending, "result is pending")
        XCTAssertEqual(calculatorBrain.description, "4×π", "Description is not equal to 4×π")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
