//
//  UserData.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//


class AppData {
    class var useInputMode: Int? {
        get {
            if let data = Utilities.LocalStorage.getValueFromUserDefaultsWithKey(key: "useInputMode") as? Int {
                return data
            }
            return nil
        }
        set {
            guard let isShowGuidance = newValue else {
                return
            }
            Utilities.LocalStorage.saveToUserDefaults(strData: isShowGuidance as AnyObject, key: "useInputMode")
        }
    }
    
    class var isShowGuidance: Bool? {
        get {
            if let data = Utilities.LocalStorage.getValueFromUserDefaultsWithKey(key: "isShowGuidance") as? Bool {
                return data
            }
            return nil
        }
        set {
            guard let isShowGuidance = newValue else {
                return
            }
            Utilities.LocalStorage.saveToUserDefaults(strData: isShowGuidance as AnyObject, key: "isShowGuidance")
        }
    }
    
    class var passCodeBeforeConfirm: String? {
        get {
            if let data = Utilities.LocalStorage.getValueFromUserDefaultsWithKey(key: "passCodeBeforeConfirm") as? String {
                return data
            }
            return nil
        }
        set {
            guard let passCodeBeforeConfirm = newValue else {
                return
            }
            Utilities.LocalStorage.saveToUserDefaults(strData: passCodeBeforeConfirm as AnyObject, key: "passCodeBeforeConfirm")
        }
    }
    
    class var passCode: String? {
        get {
            if let data = Utilities.LocalStorage.getValueFromUserDefaultsWithKey(key: "passCode") as? String {
                return data
            }
            return nil
        }
        set {
            guard let passcode = newValue else {
                return
            }
            Utilities.LocalStorage.saveToUserDefaults(strData: passcode as AnyObject, key: "passCode")
        }
    }
    
    class var storeCode: String? {
        get {
            if let data = Utilities.LocalStorage.getValueFromUserDefaultsWithKey(key: "storeCode") as? String {
                return data
            }
            return nil
        }
        set {
            guard let storeCode = newValue else {
                return
            }
            Utilities.LocalStorage.saveToUserDefaults(strData: storeCode as AnyObject, key: "storeCode")
        }
    }
    
    class var isUseBiometric: Bool? {
        get {
            if let data = Utilities.LocalStorage.getValueFromUserDefaultsWithKey(key: "isUseBiometric") as? Bool {
                return data
            }
            return nil
        }
        set {
            guard let storeCode = newValue else {
                return
            }
            Utilities.LocalStorage.saveToUserDefaults(strData: storeCode as AnyObject, key: "isUseBiometric")
        }
    }
    
}
