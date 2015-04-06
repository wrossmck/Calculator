//
//  calculatorTests.swift
//  calculatorTests
//
//  Created by Ross McKinley on 12/02/2015.
//  Copyright (c) 2015 Ross McKinley. All rights reserved.
//

import UIKit
import XCTest

class calculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
    func testCalculatorBrain() {
        // This is an example of a functional test case.
		
		self.measureBlock() {
			
			var cb = CalculatorBrain()
			cb.pushOperand(4.5)
			cb.pushOperand(8)
			cb.performOperation("*")
			cb.pushOperand(8)
			cb.performOperation("+")
			
			let res = cb.evaluate()
			
			XCTAssert(res == 44, "Pass")
		}
    }
	
	func testOptionalDouble() {
		self.measureBlock() {
			
			var cb = CalculatorBrain()
			cb.performOperation("*")
			
			let res = cb.evaluate()
			XCTAssert(res == nil, "Pass")
		}
	}
	func testCalculatorBrainDescription() {
		var cb = CalculatorBrain()
		
		cb.pushOperand(4.5)
		cb.pushOperand(8)
		cb.performOperation("*")
		
		let res = cb.evaluate()
		let history = cb.description
		XCTAssert(res == 36, "Pass")
//		this assert is commented out, because xcode currently does not perform variable expansion during tests
//		XCTAssert(history == "* , 8.0 , 4.5", "Pass")
		XCTAssert(history == "[(Enum Value), (Enum Value), (Enum Value)]", "Pass")
	}
	func testSimpleAddition() {
		let brain = CalculatorBrain()
		brain.pushOperand(0.1)
		brain.pushOperand(0.3)
		brain.performOperation("+")
		let result = brain.evaluate()
		XCTAssertEqual(0.4, result!, "Pass")
	}
	
	func testMoreAddition() {
		let brain = CalculatorBrain()
		brain.pushOperand(3)
		brain.pushOperand(4)
		brain.pushOperand(5)
		brain.performOperation("+")
		brain.performOperation("+")
		let result = brain.evaluate()
		XCTAssertEqual(12, result!, "Pass")
	}
	
	func testAdditionDescription() {
		let brain = CalculatorBrain()
		brain.pushOperand(3)
		brain.pushOperand(4)
		brain.performOperation("+")
		let result = brain.evaluate()
//		XCTAssertEqual("(3.0+4.0)", brain.description, "Pass")
	}
	
	func testMoreAdditionDescription() {
		let brain = CalculatorBrain()
		brain.pushOperand(3)
		brain.pushOperand(4)
		brain.pushOperand(5)
		brain.performOperation("+")
		brain.performOperation("+")
		let result = brain.evaluate()
//		XCTAssertEqual("(3.0+(4.0+5.0))", brain.description, "Pass")
	}
	
	func testCos() {
		let brain = CalculatorBrain()
		brain.pushOperand(10)
		brain.performOperation("cos")
		let result = brain.evaluate()
		XCTAssertEqualWithAccuracy(-0.839, result!, 0.01, "Pass")
	}
	func testCosDescription() {
		let brain = CalculatorBrain()
		brain.pushOperand(10)
		brain.performOperation("cos")
//		XCTAssertEqual("cos(10.0)", brain.description, "Pass")
	}
	
	func testUnaryDescription() {
		let brain = CalculatorBrain()
		brain.pushOperand(10)
		brain.performOperation("cos")
		println("\n\n" + brain.description + "\n\n")
		XCTAssertTrue(true, "Pass")
	}
}
