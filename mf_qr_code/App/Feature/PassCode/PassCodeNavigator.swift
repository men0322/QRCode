//
//  PassCodeNavigator.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/8/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol PassCodeNavigator {
    func goToPassCode(in window: UIWindow?)
}

struct DefaultPassCodeNavigator: PassCodeNavigator {
    func goToPassCode(in window: UIWindow?) {
        if let window = window {
            window.rootViewController = R.storyboard.passCode().instantiateInitialViewController()
            window.makeKeyAndVisible()
        }
    }
}
