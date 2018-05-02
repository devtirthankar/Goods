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
    
    var products = [GDProduct]()
    var stores = [GDStore]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForTitleViews()
        _collectionView.delegate = self
        _collectionView.dataSource = self
        
        _collectionView.register(UINib.init(nibName: cellProductIdentifier, bundle: nil), forCellWithReuseIdentifier: cellProductIdentifier)
        _collectionView.register(UINib.init(nibName: cellStoreIdentifier, bundle: nil), forCellWithReuseIdentifier: cellStoreIdentifier)
        fetchStores()
        fetchProducts()
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
            return products.count
        }
        else {
            return stores.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if _segmentControl.selectedSegmentIndex == 0 {
            let product: GDProduct = products[indexPath.row]
            let cell: GDStoreThumbnailCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellProductIdentifier, for: indexPath) as! GDStoreThumbnailCell
            
            
            //cell.thumbImageView.image = UIImage.init(named:imageName)
            cell.titleLabel.text = product.name
            //cell.loadThumbImage(url: product)
            return cell;
        }
        else {
            let store: GDStore = stores[indexPath.row]
            let cell: GDStoreBannerCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellStoreIdentifier, for: indexPath) as! GDStoreBannerCell
            cell.titleLabel.text = store.name
            cell.descriptionLabel.text = store.name
            cell.loadBannerImage(url: store.image)
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
                
                //cell.descriptionLabel.text = descriptions[indexPath.row]
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
    
    //MARK: Fetch Data
    func fetchStores() {
        GDWebServiceManager.sharedManager.getStores(block: {[weak self](response, error) in
            DispatchQueue.main.async {
                if let list = response as? [GDStore] {
                    self?.stores = list
                    self?._collectionView.reloadData()
                }
            }
        })
    }
    
    func fetchProducts() {
        GDWebServiceManager.sharedManager.getProducts(block: {[weak self](response, error) in
            DispatchQueue.main.async {
                if let list = response as? [GDProduct] {
                    self?.products = list
                    self?._collectionView.reloadData()
                }
            }
        })
    }

}
