//
//  ConfirmPassCodeViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/13/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ConfirmPassCodeViewController: BaseViewController {

    @IBOutlet weak var numberPadView: CustomNumberPad!
    @IBOutlet var pinIndicators: [IndicatorView]!
    
    let verifySuccess = PublishSubject<SettingModelUI.NavigateType?>()
    
    let viewModel = ConfirmPassCodeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = ConfirmPassCodeViewModel.Input(
            inputNumberTrigger: numberPadView
                .viewModel
                .numberPadProcessor
                .callBackValue
                .asDriver()
        )
        
        let outPut = viewModel.transform(input)
        
        outPut.fillNumber
            .do(onNext: { numberTotal in
                self.drawPin(number: numberTotal - 1)
            })
            .drive()
            .disposed(by: disposeBag)
        
        outPut.confirmSuccess
            .do(onNext: { numberTotal in
                self.verifySuccess.onNext(self.viewModel.settingNavigateType)
            })
            .drive()
            .disposed(by: disposeBag)
        
        outPut.confirmError
            .do(onNext: { numberTotal in
                self.numberPadView.viewModel.handleTapClearAll()
            })
            .drive()
            .disposed(by: disposeBag)
    }
    
    func drawPin(number: Int) {
        for i in 0..<pinIndicators.count {
            let pin: IndicatorView = pinIndicators[i]
            pin.backgroundColor = i > number ? UIColor.clear : UIColor.lightGray
        }
    }
}
