//
//  GDStoreThumbnailCell.swift
//  Goods
//
//  Created by Nabanita on 11/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit
import Kingfisher

protocol GDStoreThumbnailCellDelegate {
    func bringUpProductScreen()
}

class GDStoreThumbnailCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var overlayImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: GDStoreThumbnailCellDelegate?
    
    override func awakeFromNib() {
    // Initialization code
        super.awakeFromNib()
        
        //thumbImageView.layer.cornerRadius = 10.0//thumbImageView.frame.height * 0.5
        //overlayImageView.layer.cornerRadius = 10.0//overlayImageView.frame.height * 0.5
        
        //containerView.layer.borderColor = UIColor.black.cgColor
        //containerView.layer.borderWidth = 1.0
        
        /*
        containerView.layer.masksToBounds = true
        //containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        containerView.layer.shadowOpacity = 1.0
        
        containerView.clipsToBounds = false
        */

    }
    
    func loadThumbImage(url: String?) {
        thumbImageView?.kf.indicatorType = .activity
        if let imageUrl = url {
            let placeholderImage = UIImage.init(named: "thumbPlaceholder")
            thumbImageView?.kf.setImage(with: URL(string: imageUrl), placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            })
        }
    }
    
}
