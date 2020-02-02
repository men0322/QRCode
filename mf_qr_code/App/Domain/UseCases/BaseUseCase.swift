//
//  BaseUseCase.swift
//  Coupon
//
//  Created by Nguyen Quoc Cuong on 11/21/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

protocol BaseUseCase {
    associatedtype Output
    associatedtype Input
    func run(_ input: Input) -> Observable<Output>
}

extension BaseUseCase {
    
    func execute(_ input: Input) -> Observable<Output> {
        return self.run(input)
        .observeOn(MainScheduler.instance)
        .do(onError: { _ in
            NetworkActivityIndicatorManager.shared.endActivity()
        }, onCompleted: {
            NetworkActivityIndicatorManager.shared.endActivity()
        }, onSubscribe: {
            NetworkActivityIndicatorManager.shared.startActivity()
        })

    }
}

struct ParamNone {
    
}
