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
    
    @IBOutlet weak var _serialNumber: UILabel!
    @IBOutlet weak var _productName: UILabel!
    @IBOutlet weak var _price: UILabel!
    
    @IBOutlet weak var _serialNoView: UIView!
    @IBOutlet weak var _cellContainerView: UIView!
    @IBOutlet weak var _quantity: UITextField!
    
    @IBOutlet weak var _deleteButton: UIButton!
    @IBOutlet weak var _thumbImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        _deleteButton.layer.cornerRadius = _deleteButton.frame.height * 0.5
//        _deleteButton.layer.borderWidth = 1.0
//        _deleteButton.layer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor//UIColor.init(colorLiteralRed: 41.0/256.0, green: 190.0/256.0, blue: 136.0/256.0, alpha: 1.0).cgColor
//        _deleteButton.setTitleColor(UIColor.colorForHex(GDColor.ThemeColor as NSString), for: .normal)
        _cellContainerView.layer.cornerRadius = 10.0
        _cellContainerView.clipsToBounds = true
        
        _serialNoView.layer.cornerRadius = _serialNoView.frame.height * 0.5
        _serialNoView.clipsToBounds = true
        
        _serialNoView.layer.borderWidth = 1.0
        _serialNoView.layer.borderColor = UIColor.colorForHex(GDColor.GreyDark as NSString).cgColor
        
        _thumbImage.layer.cornerRadius = 20.0
    }
    
}
