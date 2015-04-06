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
		enter()
		if let operation = sender.currentTitle{
			displayValue = brain.performOperation(operation)
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
	
	var displayValue: Double? {
		get {
			history.text = brain.description
			return NSNumberFormatter().numberFromString(display.text!)?.doubleValue
		}
		set {
			history.text = brain.description
			if let num = newValue {
				display.text = "\(num)"
			} else {
				display.text = "0"
			}
			userIsInTheMiddleOfTypingNumber = false
			userIsInTheMiddleOfTypingFraction = false
		}
	}
}
