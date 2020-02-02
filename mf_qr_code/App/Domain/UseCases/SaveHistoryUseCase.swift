//
//  SaveHistoryUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift

class SaveHistoryUseCase: BaseUseCase {
    typealias Output = Bool
    typealias Input = History
    let repository: HistoryRepository
    
    init(repository: HistoryRepository) {
        self.repository = repository
    }
    
    func run(_ input: Input) -> Observable<Output> {
        return repository.saveHistory(history: input)
    }
}
