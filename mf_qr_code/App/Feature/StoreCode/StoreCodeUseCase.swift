//
//  StoreCodeUseCase.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/11/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

protocol StoreCodeUseCaseType {
    func saveStoreCode(storeCode: String)
}

struct StoreCodeUseCase: StoreCodeUseCaseType {
    
    func saveStoreCode(storeCode: String) {
        AppData.storeCode = storeCode
    }
}
