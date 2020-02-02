//
//  DefaultTheme.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/19/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

enum DefaultTheme {
    static let defaultTheme1: Theme = {
        let theme = Theme(name: "Basic Theme")
        theme.bodyTextColor = ColorHexConvertiable(hex: "9A9A9A")
        theme.calculatorBackgroundColor = ColorHexConvertiable(hex: "FF5722")
        theme.navigationBarColor = ColorHexConvertiable(hex: "FFFFFF")
        theme.backgroundViewColor = ColorHexConvertiable(hex: "FFFFFF")
        return theme
    }()
    
    static let defaultTheme2: Theme = {
        let theme = Theme(name: "Dark Theme")
        theme.bodyTextColor = ColorHexConvertiable(hex: "FFFFFF")
        theme.calculatorBackgroundColor = ColorHexConvertiable(hex: "C8DDE5")
        theme.navigationBarColor = ColorHexConvertiable(hex: "9A9A9A")
        theme.backgroundViewColor = ColorHexConvertiable(hex: "9A9A9A")
        return theme
    }()
    
    static let all: [Theme] = [
        defaultTheme1,
        defaultTheme2
    ]
    
    static func themeWithName(name: String?) -> Theme {
        let currentTheme = DefaultTheme.all.filter { $0.name == name ?? defaultTheme1.name}
        return currentTheme.first ?? DefaultTheme.defaultTheme1
    }
}
