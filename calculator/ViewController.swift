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
	
	var userIsInTheMiddleOfTypingNumber: Bool = false
	
	@IBAction func appendDigit(sender: UIButton) {
		let digit = sender.currentTitle!
		if userIsInTheMiddleOfTypingNumber {
			display.text = display.text! + digit
		} else {
			display.text = digit
			userIsInTheMiddleOfTypingNumber = true
		}
	}
}
