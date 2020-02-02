//
//  SearchStoreCodeTableViewCell.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/11/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

class SearchStoreCodeTableViewCell: UITableViewCell {
    @IBOutlet weak var storeCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var storeCodeUI: SearchStoreCodeUI? {
        didSet {
            storeCodeLabel.text = storeCodeUI?.storeCode
        }
    }

}
