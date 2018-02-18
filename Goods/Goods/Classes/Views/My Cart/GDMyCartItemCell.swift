//
//  GDMyCartItemCell.swift
//  Goods
//
//  Created by Nabanita on 19/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import Foundation
import UIKit

class GDMyCartItemCell: UICollectionViewCell {
    
    @IBOutlet weak var _deleteButton: UIButton!
    @IBOutlet weak var _thumbImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _deleteButton.layer.cornerRadius = _deleteButton.frame.height * 0.5
        _deleteButton.layer.borderWidth = 1.0
        _deleteButton.layer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor//UIColor.init(colorLiteralRed: 41.0/256.0, green: 190.0/256.0, blue: 136.0/256.0, alpha: 1.0).cgColor
        _deleteButton.setTitleColor(UIColor.colorForHex(GDColor.ThemeColor as NSString), for: .normal)
        _thumbImage.layer.cornerRadius = 20.0
    }
    
}
