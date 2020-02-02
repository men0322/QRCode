//
//  HistoryViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/21/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

class HistoryViewController: BaseViewController {
    
    @IBOutlet weak var clearButton: UIButton!
    
    let viewModel = HistoryViewModel(
        useCase: HistoryViewModel.UseCase(getHistoryUseCase: GetHistoryUseCase(repository: HistoryDataRepository()), deleteHistoryUseCase: DeleteHistoryUseCase(repository: HistoryDataRepository()), updateHistoryUseCase: UpdateMemoHistoryUseCase(repository: HistoryDataRepository()), deleteAllHistoryUseCase: DeleteAllHistoryUseCase(repository: HistoryDataRepository())))
    
    @IBOutlet weak var tableView: UITableView!
    
    let deleteTrigger = PublishSubject<IndexPath>()
    let updateMemo = PublishSubject<(IndexPath, String)>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        
        let input = HistoryViewModel.Input(
            loadTrigger: Driver.just(()),
            deleteTrigger: deleteTrigger.asDriverOnErrorJustComplete(),
            updateMenoTrigger: updateMemo.asDriverOnErrorJustComplete(),
            clearHistoriesTrigger: clearButton.rx.tap.asDriver()
        )
        
        let outPut = viewModel.transform(input)
        
        outPut.histories.asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, history in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyTableViewCell, for: indexPath) ?? UITableViewCell()
                self?.config(cell, at: indexPath, with: history)
                return cell
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(History.self)
            .asObservable()
            .subscribe(onNext: { history in
                if let qrCodeView = R.storyboard.main_Iphone.iphoneQRCodeViewController() {
                    qrCodeView.value = history.price
                    self.navigationController?.pushViewController(qrCodeView, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        outPut.deleteHistory
            .drive()
            .disposed(by: disposeBag)
        
        outPut.loadTrigger
            .drive()
            .disposed(by: disposeBag)
        
        outPut.updateHistory
            .drive()
            .disposed(by: disposeBag)
        
        outPut.clearHistories
            .drive()
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath, with history : History) {
        if let cell = cell as? HistoryTableViewCell {
            cell.history = history
        }
    }
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, index) in
            guard let weakSelf = self else { return }
            weakSelf.deleteTrigger.onNext(index)
        }
        let editMemo = UITableViewRowAction(style: .normal, title: "EditMeno") { [weak self] (action, index) in
            self?.alertEditMemo(index: index)
        }
        editMemo.backgroundColor = UIColor.green
        
        return [deleteAction, editMemo]
    }
    
    func alertEditMemo(index: IndexPath) {
        let alert = UIAlertController(title: "Edit", message: "Edit Memo", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:{ [weak self] (UIAlertAction)in
            guard alert.textFields?.isEmpty == false,
                let textField = alert.textFields?[0] else {
                    return
                }
            self?.updateMemo.onNext((index, textField.text ?? "Memo"))
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
    
    func configurationTextField(textField: UITextField!){
        textField.placeholder = "Memo"
    }
}
