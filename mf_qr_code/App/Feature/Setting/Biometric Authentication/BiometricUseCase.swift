//
//  BiometricUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/13/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol BiometricUseCaseType {
    func isUseBiometricAuthentication(isUse: Bool)
}

struct BiometricUseCase: BiometricUseCaseType {
    func isUseBiometricAuthentication(isUse: Bool) {
        AppData.isUseBiometric = isUse
    }
}
