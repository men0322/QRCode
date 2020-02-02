//
//  AppController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/4/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxSwift

class AppController {
    var window: UIWindow!
    
    static let shared = AppController()
    
    let disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        openAppFlow()
    }
    
    func openAppFlow() {
        checkGuidance()
    }
    
    func checkGuidance() {
        (AppData.isShowGuidance ?? false) == false ? gotoGuidanceView() : checkPassCode()
    }
    
    func checkPassCode() {
        AppData.passCode == nil ? gotoPassCode() : checkStoreCode()
    }
    
    func checkStoreCode() {
        AppData.storeCode == nil ? gotoStoreCode() : gotoMainView()
    }
}

extension AppController {
    
    func gotoStoreCode() {
        let storeCodeNavigator = DefaultStoreCodeNavigator()
        storeCodeNavigator.goToStoreCode(in: window)
    }
    
    func gotoPassCode() {
        let passCodeNavigator = DefaultPassCodeNavigator()
        passCodeNavigator.goToPassCode(in: window)
    }
    
    func gotoLoginView() {
        let loginNavigator = DefaultLoginNavigator()
        loginNavigator.goToLogin(in: window)
    }
    
    func gotoMainView() {
        let mainNavigator = DefaultMainNavigator()
        mainNavigator.goToMain(in: window)
    }
    
    func gotoGuidanceView() {
        let introNavigator = DefaultIntroNavigator()
        introNavigator.goToIntro(in: window)
    }
    
    func gotoSetting() {
        let passCodeNavigator = DefaultSettingNavigator()
        passCodeNavigator.goToSetting(in: window)
    }
}
