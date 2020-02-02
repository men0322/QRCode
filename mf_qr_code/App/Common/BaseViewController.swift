//
//  BaseViewController.swift
//  Coupon
//
//  Created by Nguyen Quoc Cuong on 11/23/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

class BaseViewController: UIViewController {

    private let loading = PublishSubject<Bool>()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func asLoadingObserver() -> PublishSubject<Bool> {
        return loading.asObserver()
    }
    
}
