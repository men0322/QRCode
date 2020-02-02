//
//  PassCodeEnum.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/8/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

enum PassCodeType: Int {
    case fillPass = 0
    case confirmPass
    
    func titleWithType() -> String {
        switch self {
        case .fillPass:
            return R.string.localizable.passcodeTitleFillPass()
        case .confirmPass:
            return R.string.localizable.passcodeTitleConfirmPass()
        }
    }
}
