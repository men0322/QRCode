//
//  SettingViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class SettingViewModel: BaseViewModel, ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let sections: Driver<[SettingModelUI]>
    }
    
    func transform(_ input: SettingViewModel.Input) -> SettingViewModel.Output {
        let sections = input.loadTrigger
            .map { _ in self.createPassCodeUIs() }
        return Output(sections: sections)
    }
    
    func createPassCodeUIs() -> [SettingModelUI] {
        return [
            SettingModelUI(title: "加盟店コード 1234",
                           navigatorType: .storeCode),
            SettingModelUI(title: "パスコードの設定",
                           navigatorType: .passCode),
            SettingModelUI(title: "計算機モードの切り替え",
                           navigatorType: .calculateMode),
            SettingModelUI(title: "Biometric Authentication",
                           navigatorType: .biometric),
            SettingModelUI(title: "Theme Setting",
                           navigatorType: .theme),
            SettingModelUI(title: "History",
                           navigatorType: .history)
        ]
    }
}
