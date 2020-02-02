//
//  ConfirmPassCodeViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/14/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class ConfirmPassCodeViewModel: BaseViewModel, ViewModelType {
    var settingNavigateType: SettingModelUI.NavigateType?
    
    struct Input {
        let inputNumberTrigger: Driver<String>
    }
    
    struct Output {
        let fillNumber: Driver<Int>
        let confirmSuccess: Driver<Void>
        let confirmError: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let fillNumber = input.inputNumberTrigger
            .map { string in
                string.count
            }
        
        let confirmSuccess = input.inputNumberTrigger
            .filter { $0.count >= Constants.PassCode.totalPinNumber }
            .filter { $0 == AppData.passCode }
            .debounce(0.5)
            .mapToVoid()
        
        let confirmError = input.inputNumberTrigger
            .filter { $0.count >= Constants.PassCode.totalPinNumber }
            .filter { $0 != AppData.passCode }
            .debounce(0.5)
            .mapToVoid()
        
        return Output(fillNumber: fillNumber,
                      confirmSuccess: confirmSuccess,
                      confirmError: confirmError)
    }
}
