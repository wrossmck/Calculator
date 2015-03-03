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
		op = sender.currentTitle!
		if userIsInTheMiddleOfTypingNumber{
			enter()
		}
		
		switch op {
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
	var op = String()
	@IBAction func enter() {
		if op != ""{
			op = op + " , "
		}
		
		if displayValue.description == π {
			history.text! = "π , " + history.text!
		} else if userIsInTheMiddleOfTypingNumber {
			history.text! = op + displayValue.description + " , " + history.text!
		} else {
			history.text! = op +  history.text!
		}
		
		userIsInTheMiddleOfTypingNumber = false
		userIsInTheMiddleOfTypingFraction = false
		operandStack.append(displayValue)
		println("\(operandStack)")
		op = ""
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
