//
//  Realm+Result.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RealmSwift

extension Results {
    
    func toArray() -> [Element] {
        return self.map{$0}
    }
}

extension RealmSwift.List {
    
    func toArray() -> [Element] {
        return self.map{$0}
    }
}
