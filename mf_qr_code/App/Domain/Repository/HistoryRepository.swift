//
//  HistoryRepository.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

protocol HistoryRepository {
    func getHistory() -> Observable<[History]>
    func saveHistory(history: History) -> Observable<Bool>
    func deleteHistory(history: History) -> Observable<Bool>
    func updateMemoHistory(history: History, memo: String) -> Observable<Bool>
    func deleteAllHistory() -> Observable<Bool>
}
