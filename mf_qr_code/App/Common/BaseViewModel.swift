//
//  BaseViewModel.swift
//  Coupon
//
//  Created by Nguyen Quoc Cuong on 11/23/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import RxSwift

class BaseViewModel {

    private let error = PublishSubject<Error?>()
    
    let disposeBag = DisposeBag()
    
    func asErrorObserver() -> PublishSubject<Error?> {
        return error.asObserver()
    }
}
