//
//  ThemeData.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/19/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class ThemeData {
    class var currentThemeName: String? {
        get {
            if let data = Utilities.LocalStorage.getValueFromUserDefaultsWithKey(key: "currentThemeName") as? String {
                return data
            }
            return DefaultTheme.defaultTheme1.name
        }
        set {
            guard let currentThemeName = newValue else {
                return
            }

            Utilities.LocalStorage.saveToUserDefaults(strData: currentThemeName as AnyObject, key: "currentThemeName")
        }
    }
    
    static var currentTheme = BehaviorRelay<Theme>(value: DefaultTheme.defaultTheme1)
    
    static func updateNewTheme() {
        currentTheme.accept(DefaultTheme.themeWithName(name: ThemeData.currentThemeName))
    }
}
