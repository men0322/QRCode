//
//  IphoneCalculatorViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/5/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class IphoneCalculatorViewController: BaseViewController {
    @IBOutlet weak var calculatorView: CalculatorView!
    
    @IBOutlet weak var qrCodeButton: UIButton!
    
    @IBOutlet weak var numberPadView: CustomNumberPad!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    let viewModel = IphoneCalculatorViewModel(useCase: IphoneCalculatorViewModel.UseCase(calculatorUseCase: IphoneCalculatorUseCase(), saveHistory: SaveHistoryUseCase(repository: HistoryDataRepository())))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congifureUIs()
        bindViewModel()
    }
    
    func congifureUIs() {
        calculatorView
            .viewModel
            .calculatorProcessor
            .callBackValue
            .asObservable()
            .map({ value -> String in
                return value == "" ? "0" : value
            })
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        numberPadView
            .viewModel
            .numberPadProcessor
            .callBackValue
            .asObservable()
            .map({ value -> String in
                return value == "" ? "0" : value
            })
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        subscribeThemeChange().disposed(by: disposeBag)

        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let qrCodeTrigger = qrCodeButton.rx.tap.asDriver().map { _ in self.history() }
        
        let input = IphoneCalculatorViewModel.Input(loadTrigger: viewWillAppear,
                                                    selectQrCodeTrigger: qrCodeTrigger)
        let output = viewModel.transform(input)
        
        output.calculatorMode
            .do(onNext: { mode in
                self.resetData()
                switch mode {
                    case .calculator:
                        self.calculatorView.isHidden = false
                    
                    case .numberPad:
                        self.numberPadView.isHidden = false
                }
            })
            .drive()
            .disposed(by: disposeBag)
        
        output.selectQrCode
            .do(onNext: { (_) in
                self.performSegue(withIdentifier: R.segue.iphoneCalculatorViewController.gotoQRCode, sender: nil)
            })
            .drive()
            .disposed(by: disposeBag)
        
        
    }
    
    private func history() -> History {
       let history = History(date: Date(), price: valueLabel.text ?? "", memo: "Memo")
        return history
    }
    
    private func resetData() {
        calculatorView.isHidden = true
        numberPadView.isHidden = true
        calculatorView.viewModel.handleTapClear()
        numberPadView.viewModel.handleTapClearAll()
    }
    
    @IBAction func settingsActionClick(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.iphoneCalculatorViewController.gotoSettings, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typeInfo = R.segue.iphoneCalculatorViewController.gotoQRCode(segue: segue) {
            typeInfo.destination.value = valueLabel.text
        }
    }
}

extension IphoneCalculatorViewController: ThemeChangeable {
    func changeTheme(_ theme: Theme) {
        changeNavTheme(theme)
        view.backgroundColor = theme.backgroundViewColor?.color
    }
}

