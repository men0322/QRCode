//
//  PassCodeUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/8/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol PassCodeUseCaseType {
    func savePassCode(passCode: String)
    func savePassCodeBeforeConfirm(passCode: String)
    func getPassCodeBeforeConfirm() -> String
}

struct PassCodeUseCase: PassCodeUseCaseType {
    
    func savePassCodeBeforeConfirm(passCode: String) {
        AppData.passCodeBeforeConfirm = passCode
    }
    
    func savePassCode(passCode: String) {
        AppData.passCode = passCode
    }
    
    func getPassCodeBeforeConfirm() -> String {
        return AppData.passCodeBeforeConfirm ?? ""
    }
}

