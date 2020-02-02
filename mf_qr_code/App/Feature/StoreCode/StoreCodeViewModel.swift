//
//  StoreCodeViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/11/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class StoreCodeViewModel: BaseViewModel, ViewModelType {
    let useCase: UseCase
    
    init (useCase: UseCase) {
        self.useCase = useCase
    }
    
    struct UseCase {
        let storeCodeUseCase: StoreCodeUseCase
    }
    
    struct Input {
        let searchTrigger: Driver<Void>
        let selectionTrigger: Driver<String>
    }
    
    struct Output {
        let saveStoreCode: Driver<Void>
        let gotoSearch: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let saveStoreCode = input.selectionTrigger
            .do(onNext: { storeCode in
                self.useCase.storeCodeUseCase.saveStoreCode(storeCode: storeCode)
            })
            .mapToVoid()
        
        let gotoSearch = input.searchTrigger
        
        return Output(saveStoreCode: saveStoreCode,
                      gotoSearch: gotoSearch)
    }
}
