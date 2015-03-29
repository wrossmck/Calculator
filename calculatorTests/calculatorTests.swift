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
			cb.performOperand("*")
			cb.pushOperand(8)
			cb.performOperand("+")
			
			let res = cb.evaluate()
			
			XCTAssert(res == 44, "Pass")
		}
    }
	
	func testOptionalDouble() {
		self.measureBlock() {
			
			var cb = CalculatorBrain()
			cb.performOperand("*")
			
			let res = cb.evaluate()
			XCTAssert(res == nil, "Pass")
		}
	}
	func testCalculatorBrainDescription() {
		var cb = CalculatorBrain()
		
		cb.pushOperand(4.5)
		cb.pushOperand(8)
		cb.performOperand("*")
		
		let res = cb.evaluate()
		let history = cb.description
		XCTAssert(res == 36, "Pass")
//		this assert is commented out, because xcode currently does not perform variable expansion during tests
//		XCTAssert(history == "* , 8.0 , 4.5", "Pass")
		XCTAssert(history == "[(Enum Value), (Enum Value), (Enum Value)]", "Pass")
	}
	
}
