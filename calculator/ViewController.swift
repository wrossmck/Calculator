//
//  ViewController.swift
//  calculator
//
//  Created by Ross McKinley on 10/02/2015.
//  Copyright (c) 2015 Ross McKinley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var display: UILabel!
	@IBOutlet weak var history: UILabel!
	
	
	let π = M_PI.description
	var userIsInTheMiddleOfTypingNumber = false
	var userIsInTheMiddleOfTypingFraction = false
	
	var brain = CalculatorBrain()
	
	@IBAction func appendDigit(sender: UIButton) {
		let digit = sender.currentTitle!
		
		if userIsInTheMiddleOfTypingNumber {
			display.text = display.text! + digit
		} else {
			display.text = digit
			userIsInTheMiddleOfTypingNumber = true
			userIsInTheMiddleOfTypingFraction = false
		}
	}
	
	func pi(){
		display.text = π
		enter()
		userIsInTheMiddleOfTypingNumber = false
	}
	
	@IBAction func makeFraction(sender: UIButton) {
		if !userIsInTheMiddleOfTypingFraction {
			userIsInTheMiddleOfTypingFraction = true
			appendDigit(sender)
		}
	}
	
	@IBAction func operate(sender: UIButton) {
		if let operation = sender.currentTitle {
			if userIsInTheMiddleOfTypingNumber {
				if operation == "±" {
					let displayText = display.text!
					if (displayText.rangeOfString("-") != nil) {
						display.text = dropFirst(displayText)
					} else {
						display.text = "-" + displayText
					}
					return
				}
				enter()
			}
			if let result = brain.performOperation(operation) {
				displayValue = result
			} else {
				displayValue = nil
			}
		}
	}
	
	@IBAction func enter() {
		if let dv = displayValue {
			userIsInTheMiddleOfTypingNumber = false
			userIsInTheMiddleOfTypingFraction = false
			displayValue = brain.pushOperand(dv)
		} else {
			displayValue = 0
		}
	}
	
	@IBAction func clear() {
		brain = CalculatorBrain()
		displayValue = nil
		history.text = ""
	}
	
	@IBAction func backSpace() {
		if userIsInTheMiddleOfTypingNumber {
			let displayText = display.text!
			if count(displayText) > 1 {
				display.text = dropLast(displayText)
				if (count(displayText) == 2) && (display.text?.rangeOfString("-") != nil) {
					display.text = "-0"
				}
			} else {
				display.text = "0"
			}
		}
	}
	
	@IBAction func storeVariable(sender: UIButton) {
		if let variable = last(sender.currentTitle!) {
			if displayValue != nil {
				brain.variableHeap["\(variable)"] = displayValue
				if let result = brain.evaluate() {
					displayValue = result
				} else {
					displayValue = nil
				}
			}
		}
		userIsInTheMiddleOfTypingNumber = false
	}
	
	@IBAction func pushVariable(sender: UIButton) {
		if userIsInTheMiddleOfTypingNumber {
			enter()
		}
		if let result = brain.pushOperand(sender.currentTitle!) {
			displayValue = result
		} else {
			displayValue = nil
		}
	}
	
	var displayValue: Double? {
		get {
			return NSNumberFormatter().numberFromString(display.text!)?.doubleValue
		}
		set {
			if let num = newValue {
				display.text = "\(num)"
			} else {
				if let result = brain.evaluate(){
					display.text = "\(result)"
				} else {
					display.text = " "
				}
			}
			userIsInTheMiddleOfTypingNumber = false
			userIsInTheMiddleOfTypingFraction = false
			history.text = brain.description != "" ? brain.description + " =" : ""
		}
	}
}
