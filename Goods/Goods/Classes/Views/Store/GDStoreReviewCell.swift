//
//  GDStoreReviewCell.swift
//  Goods
//
//  Created by Nabanita on 05/01/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDStoreReviewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //TODO: create a subclass of UIImageView for Avatar
        profileImageView.layer.cornerRadius = profileImageView.frame.height * 0.5
        profileImageView.clipsToBounds = true
    }
    
    class func fromNib() -> GDStoreReviewCell?
    {
        var cell: GDStoreReviewCell?
        let nibViews = Bundle.main.loadNibNamed("GDStoreReviewCell", owner: nil, options: nil)
        for nibView in nibViews! {
            if let cellView = nibView as? GDStoreReviewCell {
                cell = cellView
            }
        }
        return cell
    }
    
    
    func preferredLayoutSizeFittingWidth(targetWidth: CGFloat) -> CGSize{
        
        let originalFrame: CGRect = self.frame
        let originalDetailsLblPreferredMaxLayoutWidth: CGFloat = self.commentLabel.preferredMaxLayoutWidth
        
        var frame: CGRect = self.frame
        frame.size = CGSize(width: targetWidth, height: 30000)
        self.frame = frame;
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        self.commentLabel.preferredMaxLayoutWidth = self.commentLabel.bounds.size.width
        
        let computedSize: CGSize = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize, withHorizontalFittingPriority: UILayoutPriorityRequired , verticalFittingPriority: UILayoutPriorityDefaultLow)
        
        let descriptionSize = CGSize(width: targetWidth,height: ceil(computedSize.height))
        self.frame = originalFrame;
        self.commentLabel.preferredMaxLayoutWidth = originalDetailsLblPreferredMaxLayoutWidth
        
        return descriptionSize
    }

    
}
