//
//  IpadMainViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/4/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class IpadMainViewController: BaseViewController {
    @IBOutlet weak var qrCodeView: QRCodeView!
    @IBOutlet weak var customNumberPadView: CustomNumberPad!
    @IBOutlet weak var calculatorView: CalculatorView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var qrCodeButton: UIButton!
    
    let viewModel = IpadMainViewModel(useCase: IpadMainViewModel.UseCase(ipadMainUseCase: IpadMainUseCase(), saveHistory: SaveHistoryUseCase(repository: HistoryDataRepository())))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congifureUIs()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        customNumberPadView
            .viewModel
            .numberPadProcessor
            .callBackValue
            .asObservable()
            .map({ value -> String in
                return value == "" ? "0" : value
            })
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        qrCodeView.isHidden = true
    }
    
    func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = IpadMainViewModel.Input(loadTrigger: viewWillAppear,
                                            selectQrCodeTrigger: qrCodeButton.rx.tap
                                                .asDriver()
                                                .map { _ in self.history() })
        
        let output = viewModel.transform(input)
        
        output.calculatorMode
            .do(onNext: { mode in
                self.resetData()
                switch mode {
                case .calculator:
                    self.calculatorView.isHidden = false
                    
                case .numberPad:
                    self.customNumberPadView.isHidden = false
                }
            })
            .drive()
            .disposed(by: disposeBag)
        
        output.selectQrCode
            .do(onNext: { (_) in
                self.qrCodeView.isHidden = false
                self.qrCodeView.showQRCodeWithMessage(message: self.valueLabel.text ?? "")
            })
            .drive()
            .disposed(by: disposeBag)
    }
    
    private func history() -> History {
        let history = History()
        history.date = Date()
        history.price = valueLabel.text ?? ""
        history.memo = "Memo"
        return history
    }
    
    private func resetData() {
        calculatorView.isHidden = true
        customNumberPadView.isHidden = true
        calculatorView.viewModel.handleTapClear()
        customNumberPadView.viewModel.handleTapClearAll()
        qrCodeView.isHidden = true
    }
}
