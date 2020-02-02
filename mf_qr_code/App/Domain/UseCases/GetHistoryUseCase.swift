//
//  GetHistoryUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class GetHistoryUseCase: BaseUseCase {
    typealias Output = [History]
    typealias Input = ParamNone
    let repository: HistoryRepository
    
    init(repository: HistoryRepository) {
        self.repository = repository
    }
    
    func run(_ input: Input) -> Observable<Output> {
        return repository.getHistory()
    }
}
