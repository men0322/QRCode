//
//  HistoryData.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RealmSwift
import RxSwift
import RxCocoa

enum HistoryData {
    struct GetHistories {
        let realm = try! Realm()
        
        func histories() -> Observable<[History]> {
            let history: [History] = realm.objects(History.self).toArray()
            return Observable.just(history)
        }
    }
    
    struct DeleteHistory {
        let realm = try! Realm()
        
        func deleteHistory(history: History) -> Observable<Bool> {
            return Observable.create { observer in
                do {
                    try self.realm.write {
                        self.realm.delete(history)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch let error {
                    observer.onError(error)
                }
                return Disposables.create {
                }
            }
        }
        
        func deleteAllHistory() -> Observable<Bool> {
            return Observable.create { observer in
                do {
                    try self.realm.write {
                        self.realm.delete(self.realm.objects(History.self))
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch let error {
                    observer.onError(error)
                }
                return Disposables.create {
                }
            }
        }
    }
    
    struct SaveHistory {
        let realm = try! Realm()
        
        func saveHistory(_ history: History) -> Observable<Bool> {
            return Observable.create {  observer in
                DispatchQueue.global(qos: .utility).async {
                    do {
                        let realm = try Realm()
                        do {
                            try realm.write {
                                realm.add(history, update: true)
                                observer.onNext(true)
                                observer.onCompleted()
                            }
                        } catch let error {
                            observer.onError(error)
                        }
                        
                        
                    } catch let error {
                        observer.onError(error)
                    }
                }
                return Disposables.create {
                }
            }
        }
    }
    
    struct UpdateHistory {
        let realm = try! Realm()
        
        func updateMemoHistory(history: History, memo: String) -> Observable<Bool> {
            return Observable.create {  observer in
                do {
                    let realm = try Realm()
                    do {
                        try realm.write {
                            let editHistory = history
                            editHistory.memo = memo
                            //realm.add(editHistory, update: true)
                            observer.onNext(true)
                            observer.onCompleted()
                        }
                    } catch let error {
                        observer.onError(error)
                    }
                    
                    
                } catch let error {
                    observer.onError(error)
                }
                return Disposables.create {
                }
            }
        }
    }
}
