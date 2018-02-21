//
//  GDProductDescriptionCell.swift
//  Goods
//
//  Created by nabanita on 21/02/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDProductDescriptionCell: UICollectionViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func fromNib() -> GDProductDescriptionCell?
    {
        var cell: GDProductDescriptionCell?
        let nibViews = Bundle.main.loadNibNamed("GDProductDescriptionCell", owner: nil, options: nil)
        for nibView in nibViews! {
            if let cellView = nibView as? GDProductDescriptionCell {
                cell = cellView
            }
        }
        return cell
    }
    
    func preferredLayoutSizeFittingWidth(targetWidth: CGFloat) -> CGSize{
        
        let originalFrame: CGRect = self.frame
        let originalDetailsLblPreferredMaxLayoutWidth: CGFloat = self.descriptionLabel.preferredMaxLayoutWidth
        
        var frame: CGRect = self.frame
        frame.size = CGSize(width: targetWidth, height: 30000)
        self.frame = frame;
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        self.descriptionLabel.preferredMaxLayoutWidth = self.descriptionLabel.bounds.size.width
        
        let computedSize: CGSize = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize, withHorizontalFittingPriority: UILayoutPriorityRequired , verticalFittingPriority: UILayoutPriorityDefaultLow)
        
        let descriptionSize = CGSize(width: targetWidth,height: ceil(computedSize.height))
        self.frame = originalFrame;
        self.descriptionLabel.preferredMaxLayoutWidth = originalDetailsLblPreferredMaxLayoutWidth
        
        return descriptionSize
    }

}
