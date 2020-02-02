//
//  CustomNumberPadViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/14/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

class CustomNumberPadViewModel: BaseViewModel {
    let numberPadProcessor = CustomNumberPadProcessor()
    
    func handleTapWithTag(tag: Int) {
        switch tag {
        case (NumberPadValueType.zero.rawValue)...(CalculatorKey.nine.rawValue):
            handleTapNumber(tag)
        case NumberPadValueType.clear.rawValue:
            handleTapDeleteLastDigit()
        default:
            break
        }
    }
    
    func handleTapNumber(_ value: Int) {
        numberPadProcessor.storeNumber(value: value)
    }
    
    func handleTapDeleteLastDigit() {
        numberPadProcessor.deleteLastDigit()
        
    }
    
    func handleTapClearAll() {
        numberPadProcessor.clearAll()
    }
}
