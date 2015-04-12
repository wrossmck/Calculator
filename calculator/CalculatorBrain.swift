//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Ross McKinley on 03/03/2015.
//  Copyright (c) 2015 Ross McKinley. All rights reserved.
//

import Foundation

class CalculatorBrain {
	
	private enum Op: Printable{
		case Operand(Double)
		case Const(String, () -> Double)
		case UnaryOperation(String, Double -> Double)
		case BinaryOperation(String, (Double, Double) -> Double)
		
		var description: String{
			get {
				switch self{
				case .Operand(let operand):
					return "\(operand)"
				case .Const(let const, _):
					return const
				case .UnaryOperation(let unary, _):
					return unary
				case .BinaryOperation(let binary, _):
					return binary
				}
			}
		}
	}
	
	typealias PropertyList = AnyObject
	var program: PropertyList {
//		guaranteed to be a property list
		get {
			return opStack.map{ $0.description }
		}
		set {
			if let opSymbols = newValue as? Array<String>{
				var newOpStack = [Op]()
				
				let nf = NSNumberFormatter()
				
				for opSymbol in opSymbols{
					if let op = knownOps[opSymbol]{
						newOpStack.append(op)
					} else if let operand = nf.numberFromString(opSymbol)?.doubleValue {
						newOpStack.append(.Operand(operand))
					}
				}
				opStack = newOpStack
			}
		}
	}
	
	private var opStack = [Op]()
	private var knownOps = [String : Op]()
	
	init (){
		func learnOp (op: Op){
			knownOps[ op.description ] = op
		}
		learnOp( Op.Const("π", {M_PI}) )
		
		learnOp( Op.BinaryOperation("*", * ) )
		learnOp( Op.BinaryOperation("+", + ) )
		learnOp( Op.BinaryOperation("-"){ $1 - $0 } )
		learnOp( Op.BinaryOperation("/"){ $1 / $0 } )
	 
		learnOp( Op.UnaryOperation("√", sqrt) )
		learnOp( Op.UnaryOperation("sin", sin ) )
		learnOp( Op.UnaryOperation("cos", cos ) )
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
			case .Const(_, let operand):
				return (operand(), remainingOps)
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
						return (operation(operand1, operand2), operandEvaluation2.remainingOps)
					}
				}
			}
		}
		return (nil, ops)
	}
	private func description(ops: [Op]) -> (result: String?, remainingOps: [Op]) {
		
		if !ops.isEmpty{
			var remainingOps = ops
			let op = remainingOps.removeLast()
			
			switch op{
			case .Operand(let operand):
				return (String(format: "%g", operand) , remainingOps)
			case .Const(let operand, _):
				return (operand, remainingOps)
			case .UnaryOperation(let operation, _):
				let operandEvaluation = description(remainingOps)
				if let operand = operandEvaluation.result{
					return ("\(operation)(\(operand))", operandEvaluation.remainingOps)
				}
			case .BinaryOperation(let operation, _):
				let operandEvaluation1 = description(remainingOps)
				if var operand1 = operandEvaluation1.result{
					if remainingOps.count - operandEvaluation1.remainingOps.count > 2 {
						operand1 = "(\(operand1))"
					}
					let operandEvaluation2 = description(operandEvaluation1.remainingOps)
					if let operand2 = operandEvaluation2.result{
						return ("\(operand2) \(operation) \(operand1)", operandEvaluation2.remainingOps)
					}
				}
			}
		}
		return (nil, ops)
	}
	var description: String {
		get {
			var (result, ops) = ("", opStack)
			do {
				var current: String?
				(current, ops) = description(ops)
				result = result == "" ? current! : "\(current!), \(result)"
			} while ops.count > 0
			return result
		}
	}
	
	
	
	
	func pushOperand(operand: Double) -> Double?{
		opStack.append(Op.Operand(operand))
		return evaluate()
	}
	
	func performOperation(symbol: String) -> Double?{
		if let operation = knownOps[symbol] {
			opStack.append(operation)
		}
		return evaluate()
	}
}