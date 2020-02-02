//
//  PassCodeChildViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/8/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import Then

class PassCodeChildViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var pinIndicators: [IndicatorView]!
    @IBOutlet weak var fillPassCodeTextField: UITextField!
    
    var passCodeType: PassCodeType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureLayout() {
        titleLabel.do {
            $0.text = passCodeType?.titleWithType()
        }
    }
}

extension PassCodeChildViewController: UITextFieldDelegate {
    
    func drawPin(number: Int) {
        for i in 0..<pinIndicators.count {
            let pin: IndicatorView = pinIndicators[i]
            pin.backgroundColor = i > number ? UIColor.clear : UIColor.lightGray
        }
    }
}
