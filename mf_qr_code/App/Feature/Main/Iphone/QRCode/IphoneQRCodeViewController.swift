//
//  IphoneQRCodeViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/5/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IphoneQRCodeViewController: BaseViewController {
    @IBOutlet weak var qrCodeView: QRCodeView!
    var value: String?
    let viewModel = IphoneQRCodeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func bindViewModel() {
        let input = IphoneQRCodeViewModel.Input(loadTrigger: Driver.just(value ?? ""))
        
        let outPut = viewModel.transform(input)
        
        outPut.stringConvert
            .do(onNext: { string in
                self.qrCodeView.showQRCodeWithMessage(message: string)
            })
            .drive()
            .disposed(by: disposeBag)
    }
}
