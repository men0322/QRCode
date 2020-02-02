//
//  IndicatorView.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/8/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

class IndicatorView: UIView {
    var isNeedClear = false
}

let kRoundKey = "kRoundKey"

protocol Roundable {
    func round()
}

extension Roundable where Self: UIView {
    func round() {
        guard self.accessibilityHint == kRoundKey else {return}
        layer.cornerRadius = frame.height/2
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension UIView: Roundable {
    open override var accessibilityHint: String? {
        didSet {
            round()
        }
    }
}
