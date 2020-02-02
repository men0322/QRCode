//
//  MainNavigator.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/4/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol MainNavigator {
    func goToMain(in window: UIWindow?)
}

final class DefaultMainNavigator: MainNavigator {
    
    func goToMain(in window: UIWindow?) {
        if let window = window {
            if UIDevice.current.userInterfaceIdiom == .pad {
                window.rootViewController = R.storyboard.main_Ipad().instantiateInitialViewController()
            } else {
                window.rootViewController = R.storyboard.main_Iphone().instantiateInitialViewController()
            }
            window.makeKeyAndVisible()
        }
    }
}
