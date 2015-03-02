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
	
	@IBAction func appendDigit(sender: UIButton) {
		let digit = sender.currentTitle!
		
		if userIsInTheMiddleOfTypingNumber {
			if digit == "π" {
				enter()
				pi()
			} else {
				println("here")
				display.text = display.text! + digit
			}
		} else {
			if digit == "π" {
				pi()
			} else {
				display.text = digit
				userIsInTheMiddleOfTypingNumber = true
				userIsInTheMiddleOfTypingFraction = false
			}
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
		op = operation
	}
	
	func perform(operation: (Double, Double) -> Double){
		if operandStack.count >= 2 {
			displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
			enter()
		} else {
			
		}
	}
	func perform(operation: (Double) -> Double){
		if operandStack.count >= 1 {
			displayValue = operation(operandStack.removeLast())
			enter()
		}
	}
	
	var operandStack = Array<Double>()
	var op = String()
	@IBAction func enter() {
		userIsInTheMiddleOfTypingNumber = false
		userIsInTheMiddleOfTypingFraction = false
		operandStack.append(displayValue)
		history.text! = displayValue.description + " " + op + " " + history.text!
		println("\(operandStack)")
	}
	
	
	var displayValue: Double {
		get {
			return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
		}
		set {
			display.text = "\(newValue)"
			userIsInTheMiddleOfTypingNumber = false
			userIsInTheMiddleOfTypingFraction = false
		}
	}
}
