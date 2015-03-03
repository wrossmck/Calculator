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
		knownOps[ "×" ]   = Op.BinaryOperation("×", * )
		knownOps[ "+" ]   = Op.BinaryOperation("+", + )
		knownOps[ "-" ]   = Op.BinaryOperation("-"){ $1 - $0 }
		knownOps[ "÷" ]   = Op.BinaryOperation("÷"){ $1 / $0 }
		
		knownOps[ "√" ]   = Op.UnaryOperation("√", sqrt)
		knownOps[ "sin" ] = Op.UnaryOperation("sin", sin )
		knownOps[ "cos" ] = Op.UnaryOperation("cos", cos )
	}
	
	func pushOperand(operand: Double){
		opStack.append(Op.Operand(operand))
	}
	
	func puerformOperand(symbol: String){
		
	}
}