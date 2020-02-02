//
//  SearchStoreCodeViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/11/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchStoreCodeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = SearchStoreCodeViewModel()
    
    let storeCallBack = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = SearchStoreCodeViewModel.Input(
            loadTrigger: Driver.just(()),
            selection: tableView.rx.itemSelected.asDriver()
        )
        
        let outPut = viewModel.transform(input)
        
        outPut.sections.asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, history in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.searchStoreCodeTableViewCell, for: indexPath) ?? UITableViewCell()
                self?.config(cell, at: indexPath, with: history)
                return cell
            }.disposed(by: disposeBag)
        
        outPut.selection
            .do(onNext: { storeCode in
                self.storeCallBack.onNext(storeCode)
            })
            .drive()
            .disposed(by: disposeBag)
        
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath, with passCodeUI : SearchStoreCodeUI) {
        if let cell = cell as? SearchStoreCodeTableViewCell {
            cell.storeCodeUI = passCodeUI
        }
    }
}
