//
//  ErrorEntity.swift
//  Coupon
//
//  Created by Nguyen Hung on 12/7/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import ObjectMapper

struct ErrorEntity {
    var code: Int?
    var message: String?
    
    init?(map: Map) {
        
    }
}

extension ErrorEntity: Mappable {
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}
