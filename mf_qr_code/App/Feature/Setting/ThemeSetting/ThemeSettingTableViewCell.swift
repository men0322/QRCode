//
//  ThemeSettingTableViewCell.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/20/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

class ThemeSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var themeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var themeUI: ThemeSettingUI? {
        didSet {
            themeNameLabel.text = themeUI?.themeName
            accessoryType = (themeUI?.isSelected ?? false) ? .checkmark : .none
        }
    }
}
