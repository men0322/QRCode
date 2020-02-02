//
//  ThemeSettingViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

class ThemeSettingViewModel: BaseViewModel, ViewModelType {
    
    let useCase: UseCase
    
    init (useCase: UseCase) {
        self.useCase = useCase
    }
    
    struct UseCase {
        let themeUseCase: ThemeSettingUseCase
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<ThemeSettingUI>
    }
    
    struct Output {
        let sections: Driver<[ThemeSettingUI]>
        let selectTheme: Driver<Void>
        let firstLoad: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let sectionsTrigger = PublishSubject<Void>()
        
        let firstLoad = input.loadTrigger.do(onNext: { (_) in
            sectionsTrigger.onNext(())
        })
        
        let sections = sectionsTrigger
            .asDriverOnErrorJustComplete()
            .map{ _ in self.themeSettingSection() }
        
        let selectTheme = input.selectTrigger
            .do(onNext: { themeUI in
                self.useCase.themeUseCase.saveTheme(themeName: themeUI.themeName ?? DefaultTheme.defaultTheme1.name)
                sectionsTrigger.onNext(())
            })
            .mapToVoid()
        
        return Output(sections: sections,
                      selectTheme: selectTheme,
                      firstLoad: firstLoad)
    }
    
    func themeSettingSection() -> [ThemeSettingUI] {
        let currentThemeName = ThemeData.currentThemeName
        var themeSettingUIs = [ThemeSettingUI]()
        let themes = DefaultTheme.all
        for theme in themes {
            let isSelect = currentThemeName == theme.name
            let themUI = ThemeSettingUI(themeName: theme.name,isSelected: isSelect)
            themeSettingUIs.append(themUI)
        }
        return themeSettingUIs
    }
}
