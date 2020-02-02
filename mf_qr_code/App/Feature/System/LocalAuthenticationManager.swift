//
//  LocalAuthenticationManager.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/6/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import LocalAuthentication

class LocalAuthenticationManager {
   
    func checkCanUseBiometrics() -> (success: Bool, errorCode: Int?) {
        let localAuthenticationContext = LAContext()
        var authError: NSError?
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            return (true, nil)
        }
        
        return (false, authError?.code)
    }
    
    func authenticationWithTouchID(message: String, isOn: Bool) -> Observable<(Bool, Bool)> {
        return Observable.create { observer in
            
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: R.string.localizable.authenticationTitleResetMessage(), reply: { success, _  in
                DispatchQueue.main.async {
                    if success {
                        observer.onNext((success, isOn))
                        observer.onCompleted()
                    }
                    observer.onError(NSError.errorWithMessage(R.string.localizable.authenticationErrorAuthenticate(), code: 111))
                }
                
            })
            
            return Disposables.create {
            }
        }
        
    }
}
