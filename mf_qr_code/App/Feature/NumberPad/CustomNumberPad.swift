//
//  CustomNumberPad.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/13/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

class CustomNumberPad: UIView {
    let viewModel = CustomNumberPadViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateFromNib()
    }
    
    private func instantiateFromNib() {
        guard let view = R.nib.customNumberPad.instantiate(withOwner: self).first as? UIView else {
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
    
    @IBAction func buttonDidSelect(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        viewModel.handleTapWithTag(tag: button.tag)
    }
}
