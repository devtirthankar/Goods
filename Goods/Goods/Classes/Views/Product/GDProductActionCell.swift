//
//  GDProductActionCell.swift
//  Goods
//
//  Created by nabanita on 21/02/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDProductActionCell: UICollectionViewCell {
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var gotoStoreButton: UIButton!
    @IBOutlet weak var visitStoreButton: UIButton!
    @IBOutlet weak var contactStoreButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUIElements()
    }
    
    func initUIElements() {
        var buttonLayer = addToCartButton.layer
        buttonLayer.cornerRadius = addToCartButton.frame.height * 0.5
        buttonLayer.borderWidth = 1.0
        buttonLayer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor
        
        buttonLayer = gotoStoreButton.layer
        buttonLayer.cornerRadius = addToCartButton.frame.height * 0.5
        buttonLayer.borderWidth = 1.0
        buttonLayer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor
        
        buttonLayer = visitStoreButton.layer
        buttonLayer.cornerRadius = addToCartButton.frame.height * 0.5
        buttonLayer.borderWidth = 1.0
        buttonLayer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor
        
        buttonLayer = contactStoreButton.layer
        buttonLayer.cornerRadius = addToCartButton.frame.height * 0.5
        buttonLayer.borderWidth = 1.0
        buttonLayer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor
    }

}
