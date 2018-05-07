//
//  GDMyCartItemCell.swift
//  Goods
//
//  Created by Nabanita on 19/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import Foundation
import UIKit

protocol GDMyCartItemCellDelegate {
    func increaseCartValue(price: Float)
    func decreaseCartValue(price: Float)
}

class GDMyCartItemCell: UICollectionViewCell {
    
    @IBOutlet weak var _serialNumber: UILabel!
    @IBOutlet weak var _productName: UILabel!
    @IBOutlet weak var _price: UILabel!
    @IBOutlet weak var _serialNoView: UIView!
    @IBOutlet weak var _cellContainerView: UIView!
    @IBOutlet weak var _quantity: UITextField!
    @IBOutlet weak var _deleteButton: UIButton!
    @IBOutlet weak var _thumbImage: UIImageView!
    var _noOfQuantity = 1
    var delegate: GDMyCartItemCellDelegate?
    var product: Product! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _cellContainerView.layer.cornerRadius = 10.0
        _cellContainerView.clipsToBounds = true
        
        _serialNoView.layer.cornerRadius = _serialNoView.frame.height * 0.5
        _serialNoView.clipsToBounds = true
        
        _serialNoView.layer.borderWidth = 1.0
        _serialNoView.layer.borderColor = UIColor.colorForHex(GDColor.GreyDark as NSString).cgColor
        
        _thumbImage.layer.cornerRadius = 20.0
    }
    
    func configureProduct(product: Product) {
        self.product = product
        _productName.text = product.productname
        _price.text = product.price?.description
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        _noOfQuantity = _noOfQuantity + 1
        _quantity.text = "\(_noOfQuantity)"
        self.delegate?.increaseCartValue(price: product.price!)
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        if _noOfQuantity > 1 {
            _noOfQuantity = _noOfQuantity - 1
            _quantity.text = "\(_noOfQuantity)"
            self.delegate?.decreaseCartValue(price: product.price!)
        }
    }
    
}
