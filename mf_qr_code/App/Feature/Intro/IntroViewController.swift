//
//  IntroViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/6/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IntroViewController: BaseViewController {
    let viewModel = IntroViewModel()
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let finishTrigger = nextButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .asDriverOnErrorJustComplete()
        
        let input = IntroViewModel.Input(
            finishTrigger: finishTrigger
        )
        
        let outPut = viewModel.transform(input)
        
        outPut.isShowGuidance
            .drive()
            .disposed(by: disposeBag)
    }
}
