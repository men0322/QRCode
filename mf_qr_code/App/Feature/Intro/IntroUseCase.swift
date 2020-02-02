//
//  IntroUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/8/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol IntroUseCaseType {
    func isShowGuidace()
}

struct IntroUseCase: IntroUseCaseType {
    func isShowGuidace() {
        AppData.isShowGuidance = true
    }
}
