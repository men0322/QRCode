//
//  CaculatorProcessor.swift
//  Caculator
//
//  Created by Nguyen Hung on 3/1/19.
//  Copyright © 2019 Nguyen Hung. All rights reserved.
//
import RxSwift
import RxCocoa

class CalculatorProcessor {
    var callBackValue = BehaviorRelay<String>(value: "")
    
    var storeOperatorKey: CalculatorKey?
    var currentOperand: String = "0"
    var previousOperand: String = "0"
    let decimalSymbol = "."
    
    func updateCallBackValue(_ value: String) {
        callBackValue.accept(value == "" ? "0" : value)
    }
    
    func storeOperand(_ value: Int) {
        currentOperand == "0" ? (currentOperand = "\(value)") : (currentOperand += "\(value)")
        updateCallBackValue(currentOperand)
    }
    
    func storeOperator(_ type: CalculatorKey) {
        if currentOperand == "0" { return }
        if storeOperatorKey != nil {
            calculateValue(storeOperatorKey!)
        }
        storeOperatorKey = type
        previousOperand = currentOperand
        currentOperand = "0"
    }
    
    func finalValue() {
        guard let storeKey = storeOperatorKey else {
            return
        }
        calculateValue(storeKey)
        storeOperatorKey = nil
    }
    
    func calculateValue(_ type: CalculatorKey) {
        let value1 = (previousOperand as NSString).doubleValue
        let value2 = (currentOperand as NSString).doubleValue
        var output = 0.0
        switch type {
        case .multiply:
            output = value1 * value2
        case .divide:
            output = value1 / value2
        case .subtract:
            output = value1 - value2
        case .add:
            output = value1 + value2
            
        default:
            break
        }
        currentOperand = formatValue(output)
        updateCallBackValue(currentOperand)
    }
    
    func deleteLastDigit() {
        if currentOperand.isEmpty { return }
        currentOperand.removeLast()
        updateCallBackValue(currentOperand)
    }
    
    func addDecimal() {
        if currentOperand.range(of: decimalSymbol) == nil {
            currentOperand += decimalSymbol
        }
        updateCallBackValue(currentOperand)
    }
    
    func clearAll() {
        currentOperand = "0"
        previousOperand = "0"
        storeOperatorKey = nil
        updateCallBackValue(currentOperand)
    }
    
    fileprivate func formatValue(_ value: Double) -> String {
        return String(format: "%d", Int(value.rounded(.toNearestOrAwayFromZero)))
    }
}
