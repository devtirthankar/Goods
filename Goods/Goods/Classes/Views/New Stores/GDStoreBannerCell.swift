//
//  GDStoreBannerCell.swift
//  Goods
//
//  Created by Nabanita on 15/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit
import Kingfisher

class GDStoreBannerCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        // Initialization code
        super.awakeFromNib()
        
        let layer = bgView.layer
        layer.masksToBounds = true
        layer.cornerRadius = 6.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.5
        bgView.clipsToBounds = false

        
    }
    
    class func fromNib() -> GDStoreBannerCell?
    {
        var cell: GDStoreBannerCell?
        let nibViews = Bundle.main.loadNibNamed("GDStoreBannerCell", owner: nil, options: nil)
        for nibView in nibViews! {
            if let cellView = nibView as? GDStoreBannerCell {
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

    func loadBannerImage(url: String?) {
        bannerImageView?.kf.indicatorType = .activity
        if let imageUrl = url {
            let placeholderImage = UIImage.init(named: "bannerPlaceholder")
            bannerImageView?.kf.setImage(with: URL(string: imageUrl), placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            })
        }
    }
}

