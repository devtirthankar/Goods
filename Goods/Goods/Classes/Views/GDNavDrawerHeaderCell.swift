//
//  GDNavDrawerHeaderCell.swift
//  Goods
//
//  Created by nabanita on 20/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDNavDrawerHeaderCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mobile: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        name.textColor = UIColor.white
//        mobile.textColor = UIColor.white
        self.backgroundColor = UIColor.colorForHex(GDColor.ThemeColor as NSString)
    }

}
