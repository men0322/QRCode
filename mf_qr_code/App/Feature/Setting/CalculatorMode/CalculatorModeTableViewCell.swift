//
//  CalculatorModeTableViewCell.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/15/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

class CalculatorModeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var calculatorModeUI: CalculatorModeUI? {
        didSet {
            titleLabel.text = calculatorModeUI?.title
            accessoryType = (calculatorModeUI?.selected ?? false) ? .checkmark : .none
        }
    }
}
