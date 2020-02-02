//
//  CaculatorViewModel.swift
//  Caculator
//
//  Created by Nguyen Hung on 3/1/19.
//  Copyright © 2019 Nguyen Hung. All rights reserved.
//


class CalculatorViewModel {
    
    let calculatorProcessor = CalculatorProcessor()
    
    func handleTapWithTag(tag: Int) {
        switch tag {
        case (CalculatorKey.zero.rawValue)...(CalculatorKey.nine.rawValue):
            handleTapNumber(tag - 1)
            
        case CalculatorKey.decimal.rawValue:
            handleTapDecimal()
            
        case CalculatorKey.clear.rawValue:
            handleTapClear()
            
        case CalculatorKey.delete.rawValue:
            handleTapDelete()
            
        case (CalculatorKey.multiply.rawValue)...(CalculatorKey.add.rawValue):
            handleTapOperator(tag)
            
        case CalculatorKey.equal.rawValue:
            handleTapFinalValue()
            
        default:
            break
        }
    }
    
    func handleTapNumber(_ value: Int) {
        calculatorProcessor.storeOperand(value)
    }
    
    func handleTapDecimal() {
        calculatorProcessor.addDecimal()
    }
    
    func handleTapClear() {
        calculatorProcessor.clearAll()
    }
    
    func handleTapDelete() {
        calculatorProcessor.deleteLastDigit()
    }
    
    func handleTapOperator(_ tag: Int) {
        if let type = CalculatorKey(rawValue: tag) {
            calculatorProcessor.storeOperator(type)
        }
    }
    
    func handleTapFinalValue() {
        calculatorProcessor.finalValue()
    }
}
