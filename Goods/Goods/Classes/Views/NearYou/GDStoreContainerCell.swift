//
//  GDStoreContainerCell.swift
//  Goods
//
//  Created by Nabanita on 27/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

protocol GDStoreContainerCellDelegate{
    func didSelectStoreAtIndexPath(_ indexPath: IndexPath)
}

class GDStoreContainerCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    var delegate: GDStoreContainerCellDelegate?
    
    let cellReuseIdentifier = "GDStoreThumbnailCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _collectionView.register(UINib.init(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        _collectionView.dataSource = self
        _collectionView.delegate = self
        _collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell: GDStoreThumbnailCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GDStoreThumbnailCell
        let imageName = "StoreThmb\(indexPath.row + 1).png"
        cell.thumbImageView.image = UIImage.init(named:imageName)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.section;
        let edgeInsets = self.collectionView(_collectionView, layout: collectionViewLayout, insetForSectionAt: section)
        let totalYEdgeWidth = edgeInsets.top + edgeInsets.bottom
        
        let itemHeight = Double(_collectionView.frame.size.height) - Double(totalYEdgeWidth)
        
        let totalXEdgeWidth = edgeInsets.left + edgeInsets.right
        
        let itemsInRow = 2.5
        let effectiveWidth = Double(_collectionView.frame.size.width) - Double(totalXEdgeWidth)// - Double((itemsInRow - 1) * 3);
        let itemWidth = effectiveWidth/Double(itemsInRow)
        
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        return edgeInset
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectStoreAtIndexPath(indexPath)
    }


}
