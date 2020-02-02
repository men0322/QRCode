//
//  PassCodeNavigator.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol SettingNavigator {
    func goToSetting(in window: UIWindow?)
}

final class DefaultSettingNavigator: SettingNavigator {
    
    func goToSetting(in window: UIWindow?) {
        if let window = window {
            window.rootViewController = R.storyboard.setting().instantiateInitialViewController()
            window.makeKeyAndVisible()
        }
    }
}
