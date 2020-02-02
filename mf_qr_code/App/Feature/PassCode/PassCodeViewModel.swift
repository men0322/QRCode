//
//  PassCodeViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/8/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PassCodeViewModel: BaseViewModel, ViewModelType {
    let useCase = UseCase(intro: PassCodeUseCase())
    
    struct UseCase {
        let intro: PassCodeUseCase
    }
    
    struct Input {
        let fillTrigger: Driver<(String, PassCodeType)>
    }
    
    struct Output {
        let showPin: Driver<(Int, PassCodeType)>
        let gotoConfirmView: Driver<Void>
        let confirmSuccess: Driver<Void>
        let confirmError: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let gotoConfirmViewTrigger = PublishSubject<Void>()
        let confirmSuccessTrigger = PublishSubject<String>()
        let confirmErrorTrigger = PublishSubject<Void>()
        
        let fillPassCode = input.fillTrigger
            .do(onNext: { (arg) in
                let (code, type) = arg
                let codeNumber = code.count
                if codeNumber >= Constants.PassCode.totalPinNumber {
                    switch type {
                        case .confirmPass where self.useCase.intro.getPassCodeBeforeConfirm() == code:
                            confirmSuccessTrigger.onNext(code)
                        case .confirmPass:
                            confirmErrorTrigger.onNext(())
                        case .fillPass:
                            gotoConfirmViewTrigger.onNext(())
                            self.useCase.intro.savePassCodeBeforeConfirm(passCode: code)
                    }
                }
                
            }).map { (arg) -> (Int, PassCodeType) in
                let (code, type) = arg
                return (code.count - 1, type)
            }
        
        let gotoConfirmView = gotoConfirmViewTrigger.asDriverOnErrorJustComplete()
        
        let confirmSuccess = confirmSuccessTrigger
            .do(onNext: { code in
                self.useCase.intro.savePassCode(passCode: code)
            })
            .asDriverOnErrorJustComplete()
            .mapToVoid()
        
        return Output(showPin: fillPassCode,
                      gotoConfirmView: gotoConfirmView,
                      confirmSuccess: confirmSuccess,
                      confirmError: confirmErrorTrigger.asDriverOnErrorJustComplete()
                      )
        
    }
}
