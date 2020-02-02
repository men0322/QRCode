//
//  ResponseArrayEntity.swift
//  Coupon
//
//  Created by Nguyen Hung on 12/7/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import ObjectMapper

struct ResponseArrayEntity<T: Mappable> {
    var success: Bool?
    var data: [T]?
    var errors: [ErrorEntity]?
    
    init?(map: Map) {
        
    }
}

extension ResponseArrayEntity: Mappable {
    
    mutating func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
        errors <- map["errors"]
    }
}
