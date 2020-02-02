//
//  NetworkActivityIndicatorManager.swift
//  Coupon
//
//  Created by Nguyen Quoc Cuong on 11/21/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import UIKit

class NetworkActivityIndicatorManager {
    
    static let shared = NetworkActivityIndicatorManager()
    
    private var tasks = 0
    
    private init() {}

    func startActivity() {
        sync(self) {
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }
                if UIApplication.shared.isStatusBarHidden {
                    return
                }
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                weakSelf.tasks += 1
            }
        }
    }
    
    func endActivity() {
        sync(self) {
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }
                if UIApplication.shared.isStatusBarHidden {
                    return
                }
                
                weakSelf.tasks -= 1
                
                if weakSelf.tasks <= 0 {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    weakSelf.tasks = 0
                }
            }
        }
    }
}
