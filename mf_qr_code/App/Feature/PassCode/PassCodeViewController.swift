//
//  PassCodeViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/8/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PassCodeViewController: BaseViewController {
    //@IBOutlet weak var fillPassCodeTextField: UITextField!
    
    weak var pageViewController: PassCodePageViewController!
    let viewModel = PassCodeViewModel()
    
    var currentPageIndex: Int { return pageViewController.currentPageIndex.value }
    
    @IBOutlet weak var numberPadView: CustomNumberPad!
    
    let inputTrigger = PublishSubject<(String, PassCodeType)>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureNumberPad()
    }
    
    func configureNumberPad() {
        numberPadView
            .viewModel
            .numberPadProcessor
            .callBackValue
            .asObservable()
            .subscribe(onNext: { value in
                let type = PassCodeType(rawValue: self.currentPageIndex) ?? .fillPass
                self.inputTrigger.onNext((value, type))
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = PassCodeViewModel.Input(fillTrigger: inputTrigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input)
        
        output.showPin
            .do(onNext: { (arg) in
                let (number, type) = arg
                self.pageViewController.fillPassCodeWithType(type: type, number: number)
            })
            .drive()
            .disposed(by: disposeBag)
        
        output.gotoConfirmView
            .do(onNext: { (_) in
                self.gotoConfirmType()
            })
            .drive()
            .disposed(by: disposeBag)
        
        output.confirmError
            .do(onNext: { (_) in
                self.gotoFillPassWord()
            })
            .drive()
            .disposed(by: disposeBag)
        
        output.confirmSuccess
            .do(onNext: { (_) in
                self.confirmBiometric()
            })
            .drive()
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typeInfo = R.segue.passCodeViewController.pageViewController(segue: segue) {
            pageViewController = typeInfo.destination
        }
    }
    
    func confirmBiometric() {
        let alert = UIAlertController(title: R.string.localizable.passcodeTitleAlertBiometric(), message: R.string.localizable.passcodeMessageAlertBiometric(), preferredStyle: .alert)
        let useBiometric = UIAlertAction(title: R.string.localizable.passcodeTextYes(), style: .default) { (_) in
            self.authenticationWithFaceIdAndTouchId()
        }
        alert.addAction(useBiometric)
        
        let nothanks = UIAlertAction(title: R.string.localizable.passcodeTextNoThanks(), style: .default) { (_) in
            self.view.endEditing(true)
            AppController.shared.checkPassCode()
        }
        alert.addAction(nothanks)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func authenticationWithFaceIdAndTouchId() {
        let authentication = LocalAuthenticationManager()
        let validate = authentication.checkCanUseBiometrics()
        if validate.success {
            callAuthentication(authentication: authentication)
        }
    }
    
    func callAuthentication(authentication: LocalAuthenticationManager) {
        authentication.authenticationWithTouchID(message: R.string.localizable.authenticationTitleSignas(), isOn: true)
            .asObservable()
            .observeOn(MainScheduler.instance)
            .take(1)
            .subscribe(onNext: { arg in
                let (success, isOn) = arg
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        AppData.isUseBiometric = isOn
                        AppController.shared.checkPassCode()
                    }
                }
            }).disposed(by: disposeBag)
    }
}

extension PassCodeViewController {
    func gotoConfirmType() {
        pageViewController.setPageViewContent(at: PassCodeType.confirmPass.rawValue, direction: .forward)
        clearAllPin()
    }
    
    func gotoFillPassWord() {
        pageViewController.setPageViewContent(at: PassCodeType.fillPass.rawValue, direction: .reverse)
        clearAllPin()
    }
    
    func clearAllPin() {
        numberPadView.viewModel.handleTapClearAll()
        self.pageViewController.fillPassCodeWithType(type: PassCodeType.fillPass, number: -1)
        self.pageViewController.fillPassCodeWithType(type: PassCodeType.confirmPass, number: -1)
    }
}
