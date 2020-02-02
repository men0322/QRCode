//
//  HistoryViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/21/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class HistoryViewModel: BaseViewModel, ViewModelType {
    
    let useCase: UseCase
    
    init(useCase: UseCase) {
        self.useCase = useCase
    }
    
    struct UseCase {
        let getHistoryUseCase: GetHistoryUseCase
        let deleteHistoryUseCase: DeleteHistoryUseCase
        let updateHistoryUseCase: UpdateMemoHistoryUseCase
        let deleteAllHistoryUseCase: DeleteAllHistoryUseCase
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
        let deleteTrigger: Driver<IndexPath>
        let updateMenoTrigger: Driver<(IndexPath, String)>
        let clearHistoriesTrigger: Driver<Void>
    }
    
    struct Output {
        let loadTrigger: Driver<Void>
        let histories: Driver<[History]>
        let deleteHistory: Driver<Void>
        let updateHistory: Driver<Void>
        let clearHistories: Driver<Void>
    }
    
    func transform(_ input: HistoryViewModel.Input) -> HistoryViewModel.Output {
        let loadTableViewTrigger = PublishSubject<Void>()
        
        let loadTrigger = input.loadTrigger
            .do(onNext: { (_) in
                loadTableViewTrigger.onNext(())
            })
        
        let histories = loadTableViewTrigger
            .asDriverOnErrorJustComplete()
            .flatMapLatest { _ in
                self.useCase.getHistoryUseCase.execute(ParamNone())
                    .asDriverOnErrorJustComplete()
            }
        
        let deleteHistory = input.deleteTrigger
            .withLatestFrom(histories) { ($0, $1) }
            .map { (indexPath, histories) in
                histories[indexPath.row]
            }
            .flatMapLatest { history in
                self.useCase.deleteHistoryUseCase.execute(history)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: { _ in
                loadTableViewTrigger.onNext(())
            })
            .mapToVoid()
        
        let updateHistory = input.updateMenoTrigger
            .withLatestFrom(histories) { ($0, $1)}
            .map { (arg, histories) -> (History, String) in
                let (index, memo) = arg
                let history = histories[index.row]
                return (history, memo)
            }
            .flatMapLatest { arg in
                self.useCase.updateHistoryUseCase.execute(UpdateMemoHistoryUseCase.Param(history: arg.0, memo: arg.1))
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: { _ in
                loadTableViewTrigger.onNext(())
            })
            .mapToVoid()
        
        let clearHistories = input.clearHistoriesTrigger
            .flatMapLatest { _ in
                self.useCase.deleteAllHistoryUseCase.execute(ParamNone())
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: { _ in
                loadTableViewTrigger.onNext(())
            })
            .mapToVoid()
        
        return Output(loadTrigger: loadTrigger,
                      histories: histories,
                      deleteHistory: deleteHistory,
                      updateHistory: updateHistory,
                      clearHistories: clearHistories)
    }
}
