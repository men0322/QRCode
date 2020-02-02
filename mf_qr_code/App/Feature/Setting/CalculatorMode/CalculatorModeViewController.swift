//
//  CalculatorModeViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/12/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CalculatorModeViewController: BaseViewController {

    let viewModel = CalculatorModeViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        
        let input = CalculatorModeViewModel.Input(loadTrigger: Driver.just(()),
                                                  selectTrigger: tableView.rx.modelSelected(CalculatorModeUI.self).asDriver())
        let output = viewModel.transform(input)

        output.sections.asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, mode in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.calculatorModeTableViewCell, for: indexPath) ?? UITableViewCell()
                self?.config(cell, at: indexPath, with: mode)
                return cell
            }.disposed(by: disposeBag)

        output.selectMode
            .drive()
            .disposed(by: disposeBag)

        output.firstLoad
            .drive()
            .disposed(by: disposeBag)
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath, with modelUI : CalculatorModeUI) {
        if let cell = cell as? CalculatorModeTableViewCell {
            cell.calculatorModeUI = modelUI
        }
    }
}
