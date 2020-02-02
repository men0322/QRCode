//
//  CalculatorModeViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/15/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class CalculatorModeViewModel: BaseViewModel, ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<CalculatorModeUI>
    }
    
    struct Output {
        let sections: Driver<[CalculatorModeUI]>
        let selectMode: Driver<Void>
        let firstLoad: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let sectionsTrigger = PublishSubject<Void>()
        
        let firstLoad = input.loadTrigger.do(onNext: { (_) in
            sectionsTrigger.onNext(())
        })
        
        let sections = sectionsTrigger
            .asDriverOnErrorJustComplete()
            .map { _ in self.calculatorModeSections(isUseCalculator: self.checkInputModeFromLocal()) }
        
        let selectMode = input.selectTrigger
            .do(onNext: { model in
                self.saveInputModeToLocal(typeInput: model.inputType ?? .calculator)
                sectionsTrigger.onNext(())
            }).mapToVoid()
        
        return Output(sections: sections,
                      selectMode: selectMode,
                      firstLoad: firstLoad)
    }
    
    func checkInputModeFromLocal() -> Bool {
        var isUseCalculator = true
        if let useMode = AppData.useInputMode,
            InputNumberMode(rawValue: useMode) == .numberPad {
            isUseCalculator = false
        }
        return isUseCalculator
    }
    
    func saveInputModeToLocal(typeInput: InputNumberMode) {
        AppData.useInputMode = typeInput.rawValue
    }

    func calculatorModeSections(isUseCalculator: Bool) -> [CalculatorModeUI] {
        
        
        return [CalculatorModeUI(title: R.string.localizable.settingCalculatorModeUseCalculator(),
                                 inputType: .calculator,
                                 selected: isUseCalculator),
                CalculatorModeUI(title: R.string.localizable.settingCalculatorModeUseNumberPad(),
                                 inputType: .numberPad,
                                 selected: !isUseCalculator)]
    }
}
