//
//  IphoneCalculatorUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/18/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//


protocol IphoneCalculatorUseCaseType {
    func inputNumberMode() -> InputNumberMode
}

struct IphoneCalculatorUseCase: IphoneCalculatorUseCaseType {
    func inputNumberMode() -> InputNumberMode {
        return InputNumberMode(rawValue: AppData.useInputMode ?? 1) ?? .calculator
    }
}
