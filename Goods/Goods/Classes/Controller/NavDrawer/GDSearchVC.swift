//
//  GDSearchVC.swift
//  Goods
//
//  Created by Nabanita on 10/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDSearchVC: GDBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    @IBOutlet weak var _segmentControl: UISegmentedControl!
    
    let cellProductIdentifier = "GDStoreThumbnailCell"
    let cellStoreIdentifier = "GDStoreBannerCell"
    
    let prodCount = 18
    let storeCount = 8
    
    let descriptions = ["One of the finest places to dine.", "A book shop that would give you the word of information. The store has provision for people to sit there and read books and you can buy if you like a few.", "You get varities of fruits and veggies copared to other shops and the freshness of the products would make you a loyal customer in no time.", "The best jeweller who provides attractive discounts and EMI options as well.", "The best branded paints and painting services.", "One of the finest places to dine.", "A book shop that would give you the word of information. The store has provision for people to sit there and read books and you can buy if you like a few.", "You get varities of fruits and veggies copared to other shops and the freshness of the products would make you a loyal customer in no time."]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForTitleViews()
        _collectionView.delegate = self
        _collectionView.dataSource = self
        
        _collectionView.register(UINib.init(nibName: cellProductIdentifier, bundle: nil), forCellWithReuseIdentifier: cellProductIdentifier)
        _collectionView.register(UINib.init(nibName: cellStoreIdentifier, bundle: nil), forCellWithReuseIdentifier: cellStoreIdentifier)

        // Do any additional setup after loading the view.
    }

    @IBAction func segmentControlSelected(_ sender: UISegmentedControl) {
        
        _collectionView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton){
        let tabBar = self.tabBarController as! GDTabBarController
        tabBar.openDrawer()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if _segmentControl.selectedSegmentIndex == 0 {
            return prodCount
        }
        else {
            return storeCount
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if _segmentControl.selectedSegmentIndex == 0 {
            let cell: GDStoreThumbnailCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellProductIdentifier, for: indexPath) as! GDStoreThumbnailCell
            
            var index = indexPath.row + 1
            if index > 9 {
                index = (index % 10) + 1
            }
            let imageName = "Prod\(index).png"
            cell.thumbImageView.image = UIImage.init(named:imageName)
            cell.titleLabel.text = "Product\(indexPath.row + 1)"
            return cell;
        }
        else {
            let cell: GDStoreBannerCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellStoreIdentifier, for: indexPath) as! GDStoreBannerCell
            let imageName = "StoreThmb\(indexPath.row + 1).png"
            cell.bannerImageView.image = UIImage.init(named:imageName)
            cell.descriptionLabel.text = descriptions[indexPath.row]
            return cell;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if _segmentControl.selectedSegmentIndex == 0 {
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
            if let cell = GDStoreBannerCell.fromNib() {
                
                cell.descriptionLabel.text = descriptions[indexPath.row]
                let preferredSize = cell.preferredLayoutSizeFittingWidth(targetWidth: _collectionView.frame.size.width - 6)
                return preferredSize
            }
            return CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if _segmentControl.selectedSegmentIndex == 0 {
            bringUpProductScreen()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInset = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
        return edgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func bringUpProductScreen() {
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDProductVC")
        controller?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller!, animated: true);
    }

}
