//
//  CustomNumberPadProcessor.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/14/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class CustomNumberPadProcessor {
    var callBackValue = BehaviorRelay<String>(value: "")
    
    var currentValue = "" {
        didSet {
            callBackValue.accept(currentValue)
        }
    }
    
    func storeNumber(value: Int) {
        currentValue += "\(value)"
    }
    
    func deleteLastDigit() {
        if currentValue.isEmpty { return }
        currentValue.removeLast()
    }
    
    func clearAll() {
        currentValue = ""
    }
}
