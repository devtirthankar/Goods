//
//  GDStoreSegmentHeader.swift
//  Goods
//
//  Created by Nabanita on 03/01/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import UIKit

protocol GDStoreSegmentHeaderDelegate {
    func segmentSelectedFor(index: Int)
}

class GDStoreSegmentHeader: UICollectionReusableView{
    @IBOutlet var _segmentControl : UISegmentedControl!
    var delegate : GDStoreSegmentHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func segmentControlSelected(_ sender: UISegmentedControl) {
        delegate?.segmentSelectedFor(index: sender.selectedSegmentIndex)
    }
}
