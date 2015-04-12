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
	
	func testCalculatorBrain() {
		
		var cb = CalculatorBrain()
		cb.pushOperand(4.5)
		cb.pushOperand(8)
		cb.performOperation("*")
		XCTAssert(cb.evaluate() == 36, "Calculates first Operation")
		cb.pushOperand(8)
		cb.performOperation("+")
		XCTAssert(cb.evaluate() == 44, "Calculates subsequent operations")
	}
	
	func testOptionalDouble() {
		var cb = CalculatorBrain()
		cb.performOperation("*")
		
		let res = cb.evaluate()
		XCTAssert(res == nil, "Result can be Optional")
	}
	
	func testDescription() {
		var cb = CalculatorBrain()
		
		cb.pushOperand(4.5)
		cb.pushOperand(8)
		cb.performOperation("*")
		
		XCTAssert(cb.evaluate() == 36, "Pass")
		XCTAssertEqual("4.5 * 8", cb.description, "Basic multiplication description")
	}
	
	func testSimpleAddition() {
		let cb = CalculatorBrain()
		cb.pushOperand(0.1)
		cb.pushOperand(0.3)
		cb.performOperation("+")
		XCTAssertTrue(cb.evaluate() == 0.4, "Pass")
	}
	
	func testMoreAddition() {
		let cb = CalculatorBrain()
		cb.pushOperand(3)
		cb.pushOperand(4)
		cb.pushOperand(5)
		cb.performOperation("+")
		cb.performOperation("+")
		let result = cb.evaluate()
		XCTAssertEqual(12, result!, "Pass")
	}
	
	func testAdditionDescription() {
		let cb = CalculatorBrain()
		cb.pushOperand(3)
		cb.pushOperand(4)
		cb.performOperation("+")
		let result = cb.evaluate()
		XCTAssertEqual("3 + 4", cb.description, "Pass")
	}
	
	func testMoreAdditionDescription() {
		let cb = CalculatorBrain()
		cb.pushOperand(3)
		cb.pushOperand(4)
		cb.pushOperand(5)
		cb.performOperation("+")
		cb.performOperation("+")
		let result = cb.evaluate()
		XCTAssertEqual("3 + (4 + 5)", cb.description, "Pass")
	}
	
	func testCos() {
		let cb = CalculatorBrain()
		cb.pushOperand(10)
		cb.performOperation("cos")
		let result = cb.evaluate()
		XCTAssertEqualWithAccuracy(-0.839, result!, 0.01, "Pass")
	}
	func testCosDescription() {
		let cb = CalculatorBrain()
		cb.pushOperand(10)
		cb.performOperation("cos")
		XCTAssertEqual("cos(10)", cb.description, "Pass")
	}
	
	func testUnaryDescription() {
		let cb = CalculatorBrain()
		cb.pushOperand(10)
		cb.performOperation("cos")
		println("\n\n" + cb.description + "\n\n")
		XCTAssertTrue(true, "Pass")
	}
}
