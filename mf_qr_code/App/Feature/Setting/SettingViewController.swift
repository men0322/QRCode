//
//  SettingViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/7/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = SettingViewModel.Input(
            loadTrigger: Driver.just(()),
            selection: tableView.rx.itemSelected.asDriver()
        )
        
        let outPut = viewModel.transform(input)
        
        outPut.sections.asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, history in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.passCodeTableViewCell, for: indexPath) ?? UITableViewCell()
                self?.config(cell, at: indexPath, with: history)
                return cell
            }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(SettingModelUI.self)
            .subscribe(onNext: { value in
                
                guard let type = value.navigatorType
                    else { return }
                
                switch type {
                case .storeCode, .passCode, .history:
                    self.showConfirmPassCode(with: type)
                case .calculateMode:
                    self.performSegue(withIdentifier: R.segue.settingViewController.gotoCalculatorMode, sender: nil)
                case .biometric:
                    self.performSegue(withIdentifier: R.segue.settingViewController.gotoBiometricSetting, sender: nil)
                case .theme:
                    self.performSegue(withIdentifier: R.segue.settingViewController.gotoThemeSetting, sender: nil)
                }
                
            })
            .disposed(by: disposeBag)
        
        subscribeThemeChange().disposed(by: disposeBag)
    }

    private func config(_ cell: UITableViewCell, at indexPath: IndexPath, with passCodeUI : SettingModelUI) {
        if let cell = cell as? SettingTableViewCell {
            cell.passCodeUI = passCodeUI
        }
    }
    
    private func showConfirmPassCode(with type: SettingModelUI.NavigateType) {
        if let confirmPassCode = R.storyboard.passCode.confirmPassCodeViewController() {
            confirmPassCode.viewModel.settingNavigateType = type
            confirmPassCode.verifySuccess.asObserver()
                .subscribe(onNext: { type in
                    guard let type = type else { return }
                    self.navigationController?.dismiss(animated: true, completion: {
                        self.gotoViewAfterConfirmPassCode(with: type)
                    })
                }).disposed(by: disposeBag)
            self.navigationController?.present(confirmPassCode, animated: true, completion: nil)
        }
    }
    
    func gotoViewAfterConfirmPassCode(with type: SettingModelUI.NavigateType) {
        
        switch type {
        case .storeCode:
            self.performSegue(withIdentifier: R.segue.settingViewController.gotoStoreCode, sender: nil)
        case .passCode:
            self.performSegue(withIdentifier: R.segue.settingViewController.gotoPassCode, sender: nil)
        case .history:
            self.performSegue(withIdentifier: R.segue.settingViewController.gotoHistory, sender: nil)
        default:
            break
        }
    }
}

extension SettingViewController: ThemeChangeable {
    func changeTheme(_ theme: Theme) {
        changeNavTheme(theme)
    }
}
