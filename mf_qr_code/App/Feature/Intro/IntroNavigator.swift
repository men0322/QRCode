//
//  IntroNavigator.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/6/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol IntroNavigator {
    func goToIntro(in window: UIWindow?)
}

final class DefaultIntroNavigator: IntroNavigator {
    
    func goToIntro(in window: UIWindow?) {
        if let window = window {
            window.rootViewController = R.storyboard.intro().instantiateInitialViewController()
            window.makeKeyAndVisible()
        }
    }
}
