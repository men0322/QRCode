//
//  LoginNavigator.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/4/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol LoginNavigator {
    func goToLogin(in window: UIWindow?)
}

final class DefaultLoginNavigator: LoginNavigator {
    
    func goToLogin(in window: UIWindow?) {
        if let window = window {
            window.rootViewController = R.storyboard.registration.instantiateInitialViewController()
            window.makeKeyAndVisible()
        }
    }
}
