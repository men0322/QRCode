//
//  QRCodeView.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/5/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import CoreImage

class QRCodeView: UIView {
    @IBOutlet weak var qrCodeImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateFromNib()
    }
    
    private func instantiateFromNib() {
        guard let view = R.nib.qrCodeView.instantiate(withOwner: self).first as? UIView else {
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
    
    func showQRCodeWithMessage(message: String) {
        qrCodeImage.image = generateQRCode(from: message)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
