//
//  GDOrderHistoryCell.swift
//  Goods
//
//  Created by Tirthankar M on 09/06/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDOrderHistoryCell: UICollectionViewCell {
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
