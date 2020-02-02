//
//  Constant+API.swift
//  Coupon
//
//  Created by Nguyen Quoc Cuong on 11/22/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import UIKit

extension Constants {
    
    enum APIConfig {
    
        static var domainURL = "https://moneyforward.qrcode"
        static var baseURLString = "api/v1"

        static let timeout = TimeInterval(30 * 1000)
    }
}
