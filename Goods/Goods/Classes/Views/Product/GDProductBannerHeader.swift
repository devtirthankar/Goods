//
//  GDProductBannerHeader.swift
//  Goods
//
//  Created by nabanita on 21/02/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDProductBannerHeader: UICollectionReusableView {
    
    @IBOutlet weak var _imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadThumbImage(url: String?) {
        _imageView?.kf.indicatorType = .activity
        if let imageUrl = url {
            let placeholderImage = UIImage.init(named: "bannerPlaceholder")
            _imageView?.kf.setImage(with: URL(string: imageUrl), placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            })
        }
    }
    
}
