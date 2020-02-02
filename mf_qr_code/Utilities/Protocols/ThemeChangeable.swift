//
//  ThemeChangeable.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/19/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift

protocol ThemeChangeable {
    func changeTheme(_ theme: Theme)
}

extension ThemeChangeable where Self: NSObjectProtocol {
    func subscribeThemeChange(skip: Int = 0) -> Disposable {
        return ThemeData.currentTheme
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { theme in
                self.changeTheme(theme)
            })
    }
}

extension ThemeChangeable where Self: UIViewController {
    func changeNavTheme(_ theme: Theme) {
        navigationController?.navigationBar.barTintColor = theme.navigationBarColor?.color
        navigationController?.navigationBar.tintColor = theme.bodyTextColor?.color
    }
    
}
