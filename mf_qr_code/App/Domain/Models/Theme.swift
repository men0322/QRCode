//
//  Theme.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/19/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

class Theme {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    //Navigation
    var navigationBarColor: UIColorConvertiable?
    var calculatorBackgroundColor: UIColorConvertiable?
    var bodyTextColor: UIColorConvertiable?
    var backgroundViewColor: UIColorConvertiable?
}
