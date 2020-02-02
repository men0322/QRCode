//
//  BiometricViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/12/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

class BiometricViewModel: BaseViewModel, ViewModelType {
    let useCase: UseCase
    let authentication = LocalAuthenticationManager()
    
    init (useCase: UseCase) {
        self.useCase = useCase
    }
    
    struct UseCase {
        let biometricUseCase: BiometricUseCase
    }
    
    struct Input {
        let isOnTrigger: Driver<Bool>
    }
    
    struct Output {
        let isOnBiometric: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let isOnBimometric = input.isOnTrigger
            .flatMapLatest({ isOn -> Driver<(Bool, Bool)> in
                self.authentication
                    .authenticationWithTouchID(message: R.string.localizable.authenticationTitleSignas(), isOn: isOn)
                    .take(1)
                    .asDriverOnErrorJustComplete()
            })
            .do(onNext: { arg in
                let (success, isOn) = arg
                if success {
                    self.useCase.biometricUseCase.isUseBiometricAuthentication(isUse: isOn)
                }
            })
            .map{ $0.0 }
        
        return Output(isOnBiometric: isOnBimometric)
    }
    
    func isOnSwitch() -> Bool {
        let isUseBiometric = AppData.isUseBiometric ?? false
        let validate = authentication.checkCanUseBiometrics()
        
        return isUseBiometric && validate.success
    }
}
