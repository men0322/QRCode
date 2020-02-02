//
//  CalculatorModeUI.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/15/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

struct CalculatorModeUI {
    var title: String?
    var inputType: InputNumberMode?
    var selected: Bool?
}

enum InputNumberMode: Int {
    case calculator = 1
    case numberPad
}
