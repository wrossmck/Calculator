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
		XCTAssertEqual(0.4, cb.evaluate()!, "testSimpleAddition")
	}
	
	func testMoreAddition() {
		let cb = CalculatorBrain()
		cb.pushOperand(3)
		cb.pushOperand(4)
		cb.pushOperand(5)
		cb.performOperation("+")
		cb.performOperation("+")
		let result = cb.evaluate()
		XCTAssertEqual(12, result!, "testMoreAddition")
	}
	
	func testAdditionDescription() {
		let cb = CalculatorBrain()
		cb.pushOperand(3)
		cb.pushOperand(4)
		cb.performOperation("+")
		let result = cb.evaluate()
		XCTAssertEqual("3 + 4", cb.description, "testAdditionDescription")
	}
	
	func testMoreAdditionDescription() {
		let cb = CalculatorBrain()
		cb.pushOperand(3)
		cb.pushOperand(4)
		cb.pushOperand(5)
		cb.performOperation("+")
		cb.performOperation("+")
		let result = cb.evaluate()
		XCTAssertEqual("3 + (4 + 5)", cb.description, "testMoreAdditionDescription")
	}
	
	func testCos() {
		let cb = CalculatorBrain()
		cb.pushOperand(10)
		cb.performOperation("cos")
		let result = cb.evaluate()
		XCTAssertEqualWithAccuracy(-0.839, result!, 0.01, "testCos")
	}
	func testCosDescription() {
		let cb = CalculatorBrain()
		cb.pushOperand(10)
		cb.performOperation("cos")
		XCTAssertEqual("cos(10)", cb.description, "testCosDescription")
	}
	
	func testPartialDescription() {
		let cb = CalculatorBrain()
		cb.pushOperand(10)
		cb.performOperation("+")
		XCTAssertEqual("? + 10",cb.description, "testPartialDescription")
	}
	
	func testDivideDescription() {
		let cb = CalculatorBrain()
		cb.pushOperand(10)
		cb.pushOperand(2)
		cb.performOperation("÷")
		XCTAssertEqual("10 ÷ 2", cb.description, "testDivideDescription")
	}
	
	func testConst() {
		let cb = CalculatorBrain()
		cb.performOperation("π")
		XCTAssertEqual("π", cb.description, "testConstPi")
		XCTAssertEqual(M_PI, cb.evaluate()!, "testConstPiEvaluate")
	}
	func testConstDescription() {
		let cb = CalculatorBrain()
		cb.performOperation("π")
		cb.performOperation("cos")
		XCTAssertEqual("cos(π)", cb.description, "testConstDescription")
	}
}
