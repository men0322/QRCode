//
//  IphoneQRCodeViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/12/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class IphoneQRCodeViewModel: BaseViewModel, ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<String>
    }
    
    struct Output {
        let stringConvert: Driver<String>
    }
    
    func transform(_ input: Input) -> Output {
        let stringConvert = input.loadTrigger
            .map { value in
                self.stringConvert(value: value)
            }
        
        return Output(stringConvert: stringConvert)
    }
    
    func stringConvert(value: String) -> String {
        return value
    }
}
