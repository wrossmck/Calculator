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
	
	var userIsInTheMiddleOfTypingNumber = false
	var userIsInTheMiddleOfTypingFraction = false
	
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
	
	@IBAction func makeFraction(sender: UIButton) {
		if !userIsInTheMiddleOfTypingFraction {
			userIsInTheMiddleOfTypingFraction = true
			appendDigit(sender)
		} else {
			
		}
	}
	
	@IBAction func operate(sender: UIButton) {
		let operation = sender.currentTitle!
		if userIsInTheMiddleOfTypingNumber{
			enter()
		}
		switch operation {
		case "×": perform { $1*$0 }
		case "÷": perform { $1/$0 }
		case "+": perform { $1+$0 }
		case "-": perform { $1-$0 }
		case "√": perform { sqrt($0) }
		case "sin": perform { sin($0) }
		case "cos": perform { cos($0) }
		default: break
		}
	}
	
	func perform(operation: (Double, Double) -> Double){
		if operandStack.count >= 2 {
			displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
			enter()
		}
	}
	func perform(operation: (Double) -> Double){
		if operandStack.count >= 1 {
			displayValue = operation(operandStack.removeLast())
			enter()
		}
	}
	
	var operandStack = Array<Double>()
	@IBAction func enter() {
		userIsInTheMiddleOfTypingNumber = false
		operandStack.append(displayValue)
		println("\(operandStack)")
	}
	
	
	var displayValue: Double {
		get {
			return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
		}
		set {
			display.text = "\(newValue)"
			userIsInTheMiddleOfTypingNumber = false
		}
	}
}
