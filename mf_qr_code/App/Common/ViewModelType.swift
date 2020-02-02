//
//  ViewModelType.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
