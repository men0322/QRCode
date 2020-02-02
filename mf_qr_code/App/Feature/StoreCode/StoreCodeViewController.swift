//
//  StoreCodeViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class StoreCodeViewController: BaseViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var passCodeTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    let viewModel = StoreCodeViewModel(useCase: StoreCodeViewModel.UseCase(storeCodeUseCase: StoreCodeUseCase()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    fileprivate func configureUI() {
        backgroundView.do {
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.cornerRadius = 5
        }
    }
    
    func bindViewModel() {
        let applyButtonTrigger = applyButton.rx.tap
            .asObservable()
            .flatMapLatest { (_) -> Driver<String> in
                Driver.just(self.passCodeTextField.text ?? "")
            }.asDriverOnErrorJustComplete()

        let input = StoreCodeViewModel.Input(
            searchTrigger: searchButton.rx.tap.asDriver(),
            selectionTrigger: applyButtonTrigger
        )
        
        let outPut = viewModel.transform(input)
        
        outPut.saveStoreCode
        .do(onNext: { (_) in
            AppController.shared.checkStoreCode()
        })
        .drive()
        .disposed(by: disposeBag)
        
        outPut.gotoSearch
            .do(onNext: { (_) in
                self.performSegue(withIdentifier: R.segue.storeCodeViewController.goToSearchStoreCodeView, sender: nil)
            })
            .drive()
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typeInfo = R.segue.storeCodeViewController.goToSearchStoreCodeView(segue: segue) {
            typeInfo.destination.storeCallBack.asObserver()
                .subscribe(onNext: { code in
                    self.passCodeTextField.text = code
                    self.navigationController?.dismiss(animated: true, completion: nil)
                })
                .disposed(by: disposeBag)
        }
    }
}
