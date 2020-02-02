//
//  EmptyEntity.swift
//  Coupon
//
//  Created by Nguyen Hung on 12/3/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import ObjectMapper

struct EmptyEntity: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
    }
}
