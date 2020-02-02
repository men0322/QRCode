//
//  CalculatorView.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/5/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

class CalculatorView: UIView {
    let viewModel = CalculatorViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateFromNib()
    }
    
    private func instantiateFromNib() {
        guard let view = R.nib.calculatorView.instantiate(withOwner: self).first as? UIView else {
            return
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                           options: [],
                                           metrics: nil,
                                           views: ["view": view])
        )
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                           options: [],
                                           metrics: nil,
                                           views: ["view": view])
        )
    }
    
    @IBAction func caculateButtonDidTap(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        viewModel.handleTapWithTag(tag: button.tag)
    }
}
