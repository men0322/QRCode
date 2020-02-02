//
//  HistoryDataRepository.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class HistoryDataRepository: HistoryRepository {
    func getHistory() -> Observable<[History]> {
        return HistoryData.GetHistories().histories()
    }
    
    func saveHistory(history: History) -> Observable<Bool> {
        return HistoryData.SaveHistory().saveHistory(history)
    }
    
    func deleteHistory(history: History) -> Observable<Bool> {
        return HistoryData.DeleteHistory().deleteHistory(history: history)
    }
    
    func updateMemoHistory(history: History, memo: String) -> Observable<Bool> {
        return HistoryData.UpdateHistory().updateMemoHistory(history: history, memo: memo)
    }
    
    func deleteAllHistory() -> Observable<Bool> {
        return HistoryData.DeleteHistory().deleteAllHistory()
    }
}
