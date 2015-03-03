//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Ross McKinley on 03/03/2015.
//  Copyright (c) 2015 Ross McKinley. All rights reserved.
//

import Foundation

class CalculatorBrain {
	
	enum Op{
		case Operand(Double)
		case UnaryOperation(String, Double -> Double)
		case BinaryOperation(String, (Double, Double) -> Double)
		
	}
	
	var opStack = [Op]()
	var knownOps = [String : Op]()
	
	init (){
		knownOps[ "×" ]   = Op.BinaryOperation("×"){ $1 * $0 }
		knownOps[ "÷" ]   = Op.BinaryOperation("÷"){ $1 / $0 }
		knownOps[ "+" ]   = Op.BinaryOperation("+"){ $1 + $0 }
		knownOps[ "-" ]   = Op.BinaryOperation("-"){ $1 - $0 }
		knownOps[ "√" ]   = Op.UnaryOperation("√") { sqrt($0) }
		knownOps[ "sin" ] = Op.UnaryOperation("sin"){ sin($0) }
		knownOps[ "cos" ] = Op.UnaryOperation("cos"){ cos($0) }
	}
	
	func pushOperand(operand: Double){
		opStack.append(Op.Operand(operand))
	}
	
	func puerformOperand(symbol: String){
		
	}
}