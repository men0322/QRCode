//
//  ThemeSettingViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/19/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ThemeSettingViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ThemeSettingViewModel(useCase: ThemeSettingViewModel.UseCase(themeUseCase: ThemeSettingUseCase()))
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = ThemeSettingViewModel.Input(loadTrigger: Driver.just(()),
                                                selectTrigger: tableView.rx.modelSelected(ThemeSettingUI.self).asDriver())
        
        let outPut = viewModel.transform(input)
        
        outPut.sections.asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, themeUI in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.themeSettingTableViewCell, for: indexPath) ?? UITableViewCell()
                self?.config(cell, at: indexPath, with: themeUI)
                return cell
            }.disposed(by: disposeBag)
        
        outPut.selectTheme
            .drive()
            .disposed(by: disposeBag)
        
        outPut.firstLoad
            .drive()
            .disposed(by: disposeBag)
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath, with modelUI : ThemeSettingUI) {
        if let cell = cell as? ThemeSettingTableViewCell {
            cell.themeUI = modelUI
        }
    }
}

