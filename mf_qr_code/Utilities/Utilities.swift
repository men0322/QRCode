//
//  Utilities.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

enum Utilities {
    enum LocalStorage {
        static func saveToUserDefaults(strData: AnyObject, key: String) {
            UserDefaults.standard.set(strData, forKey: key)
            UserDefaults.standard.synchronize()
        }
        
        static func saveArrayToUserDefaults(array: [AnyObject], key: String) {
            UserDefaults.standard.set(array, forKey: key)
            UserDefaults.standard.synchronize()
        }
        
        static func removeObjectiveForKey(key: String) {
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: key)
        }
        
        static func getValueFromUserDefaultsWithKey(key: String) -> AnyObject {
            return UserDefaults.standard.object(forKey: key) as AnyObject
        }
    }
    
    enum DateFormat {
        static func stringFromDate(with format: String, from date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            
            let myString = formatter.string(from: date)
            
            return myString
        }
    }
}
