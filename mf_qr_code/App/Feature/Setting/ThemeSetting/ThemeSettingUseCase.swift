//
//  ThemeSettingUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//


protocol ThemeSettingUseCaseType {
    func saveTheme(themeName: String)
}

struct ThemeSettingUseCase: ThemeSettingUseCaseType {
    func saveTheme(themeName: String) {
        ThemeData.currentThemeName = themeName
        ThemeData.updateNewTheme()
    }
}
