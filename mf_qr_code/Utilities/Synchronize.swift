//
//  Synchronize.swift
//  Coupon
//
//  Created by Nguyen Quoc Cuong on 11/21/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//
import Foundation

internal func sync(_ obj: Any, predicate: () throws -> Void) rethrows {
    objc_sync_enter(obj)
    
    defer { objc_sync_exit(obj) }
    
    try predicate()
}
