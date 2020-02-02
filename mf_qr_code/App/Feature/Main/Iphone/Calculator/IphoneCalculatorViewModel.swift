//
//  IphoneCalculatorViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/15/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class IphoneCalculatorViewModel: BaseViewModel, ViewModelType {
    
    let useCase: UseCase
    
    init(useCase: UseCase) {
        self.useCase = useCase
    }
    
    struct UseCase {
        let calculatorUseCase: IphoneCalculatorUseCase
        let saveHistory: SaveHistoryUseCase
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectQrCodeTrigger: Driver<History>
    }
    
    struct Output {
        let calculatorMode: Driver<InputNumberMode>
        let selectQrCode: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let calculatorMode = input.loadTrigger
            .map { _ in self.useCase.calculatorUseCase.inputNumberMode() }
        
        let selectQrCode = input.selectQrCodeTrigger
            .flatMapLatest { history in
                self.useCase.saveHistory.execute(history)
                    .asDriverOnErrorJustComplete()
            }
            .mapToVoid()
        
        return Output(calculatorMode: calculatorMode,
                      selectQrCode: selectQrCode)
    }
}
