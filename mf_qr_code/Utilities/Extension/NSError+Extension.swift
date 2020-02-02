//
//  NSError+Extension.swift
//  Coupon
//
//  Created by Nguyen Quoc Cuong on 11/21/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import UIKit

extension NSError {

    struct Code {
        static let unknown = 999
        static let jsonMapper = 998
        static let connectServer = 997
        static let apiErrorCode = 996
    }
    
    static func unknown() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Unknown error"]
        return NSError(domain: R.string.localizable.apiErrorUnknown(), code: Code.unknown, userInfo: userInfo)
    }
    
    static func jsonMapper() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "JSON Mapper error"]
        return NSError(domain: R.string.localizable.apiErrorInvalidResponseData(), code: Code.jsonMapper, userInfo: userInfo)
    }
    
    static func connectServer() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "REQUEST ERROR"]
        return NSError(domain: R.string.localizable.apiFailedMessage(), code: Code.connectServer, userInfo: userInfo)
    }
    
    static func errorWithMessage(_ message: String, code: Int) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "REQUEST ERROR"]
        return NSError(domain: message, code: code, userInfo: userInfo)
    }
    
    static func errorWithResponseError(_ error: Error) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "REQUEST ERROR"]
        let code = (error as NSError).code
        if code == -1009 {
            return NSError(domain: R.string.localizable.apiNoInternetMessage(), code: code, userInfo: userInfo)
        }
        return NSError(domain: R.string.localizable.apiFailedMessage(), code: Code.connectServer, userInfo: userInfo)
    }
}
