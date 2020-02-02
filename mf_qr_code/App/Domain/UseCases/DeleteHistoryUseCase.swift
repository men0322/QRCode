//
//  DeleteHistoryUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/21/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

class DeleteHistoryUseCase: BaseUseCase {
    typealias Output = Bool
    
    typealias Input = History
    
    let repository: HistoryRepository
    
    init(repository: HistoryRepository) {
        self.repository = repository
    }
    
    func run(_ input: History) -> Observable<Output> {
        return repository.deleteHistory(history: input)
    }
}
