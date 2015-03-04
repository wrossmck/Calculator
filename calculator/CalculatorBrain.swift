//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Ross McKinley on 03/03/2015.
//  Copyright (c) 2015 Ross McKinley. All rights reserved.
//

import Foundation

class CalculatorBrain {
	
	private enum Op{
		case Operand(Double)
		case UnaryOperation(String, Double -> Double)
		case BinaryOperation(String, (Double, Double) -> Double)
		
	}
	
	private var opStack = [Op]()
	private var knownOps = [String : Op]()
	
	init (){
		knownOps[ "×" ]   = Op.BinaryOperation("×", * )
		knownOps[ "+" ]   = Op.BinaryOperation("+", + )
		knownOps[ "-" ]   = Op.BinaryOperation("-"){ $1 - $0 }
		knownOps[ "÷" ]   = Op.BinaryOperation("÷"){ $1 / $0 }
		
		knownOps[ "√" ]   = Op.UnaryOperation("√", sqrt)
		knownOps[ "sin" ] = Op.UnaryOperation("sin", sin )
		knownOps[ "cos" ] = Op.UnaryOperation("cos", cos )
	}
	
	func evaluate() -> Double? {
		let (res, remainder) = evaluate(opStack)
		return res
	}
	
	private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
		if !ops.isEmpty{
			var remainingOps = ops
			let op = remainingOps.removeLast()
			
			switch op{
			case .Operand(let operand):
				return (operand, remainingOps)
			case .UnaryOperation(_, let operation):
				let operandEvaluation = evaluate(remainingOps)
				if let operand = operandEvaluation.result{
					return (operation(operand), operandEvaluation.remainingOps)
				}
			case .BinaryOperation(_, let operation):
				let operandEvaluation1 = evaluate(remainingOps)
				if let operand1 = operandEvaluation1.result{
					let operandEvaluation2 = evaluate(operandEvaluation1.remainingOps)
					if let operand2 = operandEvaluation2.result{
						return (operation(operand2, operand1), operandEvaluation2.remainingOps)
					}
				}
			}
		}
		return (nil, ops)
	}
	
	func pushOperand(operand: Double) -> Double?{
		opStack.append(Op.Operand(operand))
		return evaluate()
	}
	
	func performOperand(symbol: String) -> Double?{
		if let operation = knownOps[symbol] {
			opStack.append(operation)
		}
		return evaluate()
	}
}