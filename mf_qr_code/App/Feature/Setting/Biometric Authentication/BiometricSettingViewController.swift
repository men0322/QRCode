//
//  BiometricSettingViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/12/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BiometricSettingViewController: BaseViewController {

    @IBOutlet weak var onBiometricSwitch: UISwitch!
    
    let viewModel = BiometricViewModel(useCase: BiometricViewModel.UseCase(biometricUseCase: BiometricUseCase()))
    
    let changeStatus = PublishSubject<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIs()
        bindViewModel()
    }
    
    @IBAction func changeStatus(_ sender: Any) {
        changeStatus.onNext((sender as? UISwitch ?? UISwitch()).isOn)
    }
    
    func bindViewModel() {
        let input = BiometricViewModel.Input(
            isOnTrigger: changeStatus.asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input)
        
        output.isOnBiometric
            .do(onNext: { success in
                self.onBiometricSwitch.isOn = (success == true) ? self.onBiometricSwitch.isOn : !self.onBiometricSwitch.isOn
            })
            .drive()
            .disposed(by: disposeBag)
    }
    
    func configureUIs() {
        onBiometricSwitch.isOn = viewModel.isOnSwitch()
    }
}
