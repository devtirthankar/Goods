//
//  GDNearYouVC.swift
//  Goods
//
//  Created by Tirthankar on 08/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDNearYouVC: GDBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GDStoreContainerCellDelegate {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    
    let cellReuseIdentifier = "GDStoreThumbnailCell"
    let headerReuseIdentifier = "GDNearYouSectionHeaderView"
    let cellReuseIdentifierTopStore = "GDStoreContainerCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForTitleViews()

        // Do any additional setup after loading the view.
        _collectionView.register(UINib.init(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        _collectionView.register(UINib.init(nibName: cellReuseIdentifierTopStore, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifierTopStore)
        _collectionView.register(UINib.init(nibName: headerReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        let layout = _collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        layout?.sectionHeadersPinToVisibleBounds = true
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton){
        let tabBar = self.tabBarController as! GDTabBarController
        tabBar.openDrawer()
    }
    
    @IBAction func itemSelected(_ sender: UIButton){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDStoreVC")
        controller?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        }
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if indexPath.section == 0 {
            let cell: GDStoreContainerCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifierTopStore, for: indexPath) as! GDStoreContainerCell
            cell.delegate = self
            return cell
        }
        
        let cell: GDStoreThumbnailCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GDStoreThumbnailCell
        let imageName = "StoreThmb\(indexPath.row + 1).png"
        cell.thumbImageView.image = UIImage.init(named:imageName)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.section;
        let edgeInsets = self.collectionView(_collectionView, layout: collectionViewLayout, insetForSectionAt: section)
        let totalXEdgeWidth = edgeInsets.left + edgeInsets.right
        
        let itemsInRow = 2
        let effectiveWidth = Double(_collectionView.frame.size.width) - Double(totalXEdgeWidth) - Double((itemsInRow - 1) * 3);
        var itemWidth = effectiveWidth/Double(itemsInRow)
        
        var itemHeight = itemWidth;
        
        if section == 0 {
            itemWidth = Double(_collectionView.frame.size.width) - Double(totalXEdgeWidth)
            itemHeight = itemHeight * 0.8
        }
        
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize.init(width: collectionView.frame.size.width, height: 50.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        let header: GDNearYouSectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! GDNearYouSectionHeaderView
        

        if indexPath.section == 0 {
            header._titleLabel.text = "Top Stores"
        }else{
            header._titleLabel.text = "Near You"
        }
        
        return header;
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInset = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
        return edgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            bringUpStoreScreen()
        }
    }
    
    func bringUpStoreScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GDStoreVC")
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true);

    }
    
    //MARK: GDStoreContainerCellDelegate
    func didSelectStoreAtIndexPath(_ indexPath: IndexPath){
        bringUpStoreScreen()
    }

}
