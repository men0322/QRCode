//
//  StoreCodeNavigator.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol StoreCodeNavigator {
    func goToStoreCode(in window: UIWindow?)
}

final class DefaultStoreCodeNavigator: StoreCodeNavigator {
    
    func goToStoreCode(in window: UIWindow?) {
        if let window = window {
            window.rootViewController = R.storyboard.storeCode().instantiateInitialViewController()
            window.makeKeyAndVisible()
        }
    }
}
