//
//  ColorHexConvertiable.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/19/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol UIColorConvertiable {
    var color: UIColor? { get }
    
    var description: String? { get }
}

struct ColorHexConvertiable: UIColorConvertiable {
    var hex: String?
    
    var color: UIColor? {
        if let hex = hex {
            return UIColor(hexString: hex)
        } else {
            return nil
        }
    }
    
    var description: String? {
        return hex
    }
    
    init(hex: String?) {
        self.hex = hex
    }
}
