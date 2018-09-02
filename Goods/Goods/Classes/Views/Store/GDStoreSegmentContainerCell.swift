//
//  GDStoreSegmentContainerCell.swift
//  Goods
//
//  Created by Nabanita on 03/01/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import UIKit

protocol GDStoreSegmentContainerCellDelegate{
    func didSelectProductAtIndexPath(_ indexPath: IndexPath)
}

class GDStoreSegmentContainerCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    //var delegate: GDStoreContainerCellDelegate?
    let cellProductIdentifier = "GDStoreThumbnailCell"
    let cellStoreIdentifier = "GDStoreReviewCell"
    var _selectedSegmentIndex = 0
    var _storeId = Int64()
    var delegate: GDStoreSegmentContainerCellDelegate?
    var productList = [Product]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCollectionViewForSegment(segment: Int) {
        
        _collectionView.dataSource = self
        _collectionView.delegate = self
        
        if segment == 0 {
            _selectedSegmentIndex = 0
            _collectionView.register(UINib.init(nibName: cellProductIdentifier, bundle: nil), forCellWithReuseIdentifier: cellProductIdentifier)
        }
        else {
            _selectedSegmentIndex = 1
            _collectionView.register(UINib.init(nibName: cellStoreIdentifier, bundle: nil), forCellWithReuseIdentifier: cellStoreIdentifier)
        }
        
        _collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if _selectedSegmentIndex == 0 {
            return productList.count
        }
        else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if _selectedSegmentIndex == 0 {
            let product: Product = productList[indexPath.row]
            let cell: GDStoreThumbnailCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellProductIdentifier, for: indexPath) as! GDStoreThumbnailCell
            let prductname: String = ((Locale.current.languageCode! == "ar") ? product.productnamear : product.productname)!
            cell.titleLabel.text = prductname
            if let images = product.productimages {
                if images.count > 0 {
                    let image = images[0]
                    let imageURL = GDWebServiceManager.sharedManager.baseImageURL + "\(image.imgpath)"
                    cell.loadThumbImage(url: imageURL)
                }
            }
            return cell;
        }
        else {
            let cell: GDStoreReviewCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellStoreIdentifier, for: indexPath) as! GDStoreReviewCell
            
            cell.commentLabel.text = "Review \(indexPath.row + 1)"//descriptions[indexPath.row]
            return cell;
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if _selectedSegmentIndex == 0 {
            let section = indexPath.section;
            
            let edgeInsets = self.collectionView(_collectionView, layout: collectionViewLayout, insetForSectionAt: section)
            let totalXEdgeWidth = edgeInsets.left + edgeInsets.right
            let itemsInRow = 3
            let effectiveWidth = Double(_collectionView.frame.size.width) - Double(totalXEdgeWidth) - Double((itemsInRow - 1) * 3);
            let itemWidth = effectiveWidth/Double(itemsInRow)
            
            let itemHeight = itemWidth;
            
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else {
            if let cell = GDStoreReviewCell.fromNib() {
                
                let preferredSize = cell.preferredLayoutSizeFittingWidth(targetWidth: _collectionView.frame.size.width - 6)
                return preferredSize
            }
            return CGSize.zero
        }
        
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        return edgeInset
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if _selectedSegmentIndex == 0 {
            delegate?.didSelectProductAtIndexPath(indexPath)
        }
    }
}
