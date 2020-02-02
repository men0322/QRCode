//
//  History.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RealmSwift

class History: Object {
    @objc dynamic var date: Date! = Date() {
        didSet {
            dateString = Utilities.DateFormat.stringFromDate(with: "yyyy-MM-dd HH:mm:ss", from: Date())
        }
    }
    @objc dynamic var dateString: String! = ""
    @objc dynamic var price: String! = ""
    @objc dynamic var memo: String! = ""
    
    override static func primaryKey() -> String? {
        return "dateString"
    }
    
    convenience init(date: Date, price: String, memo: String) {
       self.init()
       self.date = date
       self.price = price
       self.memo = memo
    }
}
