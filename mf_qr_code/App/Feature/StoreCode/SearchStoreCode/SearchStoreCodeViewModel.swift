//
//  SearchStoreCodeViewModel.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/11/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

class SearchStoreCodeViewModel: BaseViewModel, ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let sections: Driver<[SearchStoreCodeUI]>
        let selection: Driver<String>
    }
    
    func transform(_ input: Input) -> Output {
        let sections = input.loadTrigger
            .map { _ in self.createStoreCodeUIs() }
        
        let selection = input.selection
            .withLatestFrom(sections) { ($0, $1) }
            .map { (index, sections) in
                sections[index.row].storeCode ?? ""
            }
        
        return Output(sections: sections,
                      selection: selection)
    }
    
    func createStoreCodeUIs() -> [SearchStoreCodeUI] {
        return [
            SearchStoreCodeUI(storeCode: "1111"),
            SearchStoreCodeUI(storeCode: "1112"),
            SearchStoreCodeUI(storeCode: "1113"),
            SearchStoreCodeUI(storeCode: "1114"),
            SearchStoreCodeUI(storeCode: "1115"),
            SearchStoreCodeUI(storeCode: "1116"),
            SearchStoreCodeUI(storeCode: "1117"),
            SearchStoreCodeUI(storeCode: "1118"),
            SearchStoreCodeUI(storeCode: "1119"),
            SearchStoreCodeUI(storeCode: "1120"),
            SearchStoreCodeUI(storeCode: "1121"),
            SearchStoreCodeUI(storeCode: "1122")
        ]
    }
}
