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
		op = sender.currentTitle!
		enter()
		// TODO fix history display area. Something is happening here with repeated entries being added into the history
		if let operation = sender.currentTitle{
			displayValue = brain.performOperand(operation)
		}
	}
	
	var op = String()
	
	@IBAction func enter() {
		if op != ""{
			op = op + " , "
		}
		if let dv = displayValue? {
		
			userIsInTheMiddleOfTypingNumber = false
			userIsInTheMiddleOfTypingFraction = false
			
			displayValue = brain.pushOperand(dv)
			op = ""
		}
	}
	
	var displayValue: Double? {
		get {
			history.text = brain.description
			if let num = NSNumberFormatter().numberFromString(display.text!) {
				return num.doubleValue
			} else {
				return nil
			}
		}
		set {
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
