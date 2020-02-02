//
//  HistoryTableViewCell.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/21/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var menoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var history: History? {
        didSet {
            dateLabel.text = Utilities.DateFormat.stringFromDate(with: "yyyy-MM-dd HH:mm:ss", from: history?.date ?? Date())
            priceLabel.text = history?.price
            menoLabel.text = history?.memo
        }
    }
}
