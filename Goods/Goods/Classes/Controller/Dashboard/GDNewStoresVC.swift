//
//  GDNewStoresVC.swift
//  Goods
//
//  Created by Tirthankar on 08/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit
import Foundation

class GDNewStoresVC: GDBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var _collectionView: UICollectionView!
    
    let cellReuseIdentifier = "GDStoreBannerCell"
    
    let descriptions = ["One of the finest places to dine.", "A book shop that would give you the word of information. The store has provision for people to sit there and read books and you can buy if you like a few.", "You get varities of fruits and veggies copared to other shops and the freshness of the products would make you a loyal customer in no time.", "The best jeweller who provides attractive discounts and EMI options as well.", "The best branded paints and painting services.", "One of the finest places to dine.", "A book shop that would give you the word of information. The store has provision for people to sit there and read books and you can buy if you like a few.", "You get varities of fruits and veggies copared to other shops and the freshness of the products would make you a loyal customer in no time."]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForTitleViews()

        // Do any additional setup after loading the view.
        _collectionView.register(UINib.init(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
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
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        let cell: GDStoreBannerCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GDStoreBannerCell
        let imageName = "StoreThmb\(indexPath.row + 1).png"
        cell.bannerImageView.image = UIImage.init(named:imageName)
        cell.descriptionLabel.text = descriptions[indexPath.row]
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let cell = GDStoreBannerCell.fromNib() {
            
            cell.descriptionLabel.text = descriptions[indexPath.row]
            let preferredSize = cell.preferredLayoutSizeFittingWidth(targetWidth: _collectionView.frame.size.width - 6)
            return preferredSize
        }
        return CGSize.zero
    }
    

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        let edgeInset = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
        return edgeInset
    }

}
