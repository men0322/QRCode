//
//  IpadMainUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/18/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol IIpadMainUseCaseType {
    func inputNumberMode() -> InputNumberMode
}

struct IpadMainUseCase: IphoneCalculatorUseCaseType {
    func inputNumberMode() -> InputNumberMode {
        return InputNumberMode(rawValue: AppData.useInputMode ?? 1) ?? .calculator
    }
}
