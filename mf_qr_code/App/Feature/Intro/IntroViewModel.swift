//
//  IntroViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class IntroViewModel: BaseViewModel, ViewModelType {
    let useCase = UseCase(intro: IntroUseCase())
    
    struct UseCase {
        let intro: IntroUseCase
    }
    
    struct Input {
        let finishTrigger: Driver<Void>
    }
    
    struct Output {
        let isShowGuidance: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let isShowGuidance = input.finishTrigger
            .do(onNext: { (_) in
                self.useCase.intro.isShowGuidace()
            })
            .do(onNext: { (_) in
                AppController.shared.checkGuidance()
            })
        
        return Output(isShowGuidance: isShowGuidance)
    }
}
