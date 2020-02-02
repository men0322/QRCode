//
//  ResponseEntity.swift
//  Coupon
//
//  Created by Nguyen Quoc Cuong on 11/21/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import ObjectMapper

struct ResponseEntity<T: Mappable> {
    var success: Bool?
    var data: T?
    var errors: [ErrorEntity]?
    
    init?(map: Map) {
        
    }
}

extension ResponseEntity: Mappable {
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
        errors <- map["errors"]
    }
}
