//
//  PassCodeModelUI.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

struct SettingModelUI {
    var title: String?
    var navigatorType: NavigateType?
    
    enum NavigateType {
        case passCode
        case storeCode
        case biometric
        case calculateMode
        case theme
        case history
    }
}
