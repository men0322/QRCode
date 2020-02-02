//
//  UpdateMemoHistoryUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/21/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

class UpdateMemoHistoryUseCase: BaseUseCase {
    
    typealias Output = Bool
    
    typealias Input = Param
    
    let repository: HistoryRepository
    
    init(repository: HistoryRepository) {
        self.repository = repository
    }
    
    func run(_ input: Input) -> Observable<Output> {
        return repository.updateMemoHistory(history: input.history, memo: input.memo)
    }
    
    struct Param {
        let history: History
        let memo: String
    }
}
