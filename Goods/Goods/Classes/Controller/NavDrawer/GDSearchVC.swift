//
//  GDSearchVC.swift
//  Goods
//
//  Created by Nabanita on 10/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDSearchVC: GDBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GDSearchViewModelDelegate {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    @IBOutlet weak var _segmentControl: UISegmentedControl!
    
    let cellProductIdentifier = "GDStoreThumbnailCell"
    let cellStoreIdentifier = "GDStoreBannerCell"

    var searchViewModel = GDSearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForTitleViews()
        _collectionView.delegate = self
        _collectionView.dataSource = self
        
        _collectionView.register(UINib.init(nibName: cellProductIdentifier, bundle: nil), forCellWithReuseIdentifier: cellProductIdentifier)
        _collectionView.register(UINib.init(nibName: cellStoreIdentifier, bundle: nil), forCellWithReuseIdentifier: cellStoreIdentifier)
        searchViewModel.fetchStores()
        searchViewModel.fetchProducts()
        searchViewModel.delegate = self
    }

    @IBAction func segmentControlSelected(_ sender: UISegmentedControl) {
        _collectionView.reloadData()
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton){
        let tabBar = self.tabBarController as! GDTabBarController
        tabBar.openDrawer()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if _segmentControl.selectedSegmentIndex == 0 {
            return searchViewModel.products.count
        }
        else {
            return searchViewModel.stores.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if _segmentControl.selectedSegmentIndex == 0 {
            let product: Product = searchViewModel.products[indexPath.row]
            let cell: GDStoreThumbnailCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellProductIdentifier, for: indexPath) as! GDStoreThumbnailCell
            cell.titleLabel.text = product.productname
            return cell;
        }
        else {
            let store: Store = searchViewModel.stores[indexPath.row]
            let cell: GDStoreBannerCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellStoreIdentifier, for: indexPath) as! GDStoreBannerCell
            cell.titleLabel.text = store.storename
            cell.descriptionLabel.text = store.storename
            cell.loadBannerImage(url: store.logo?.description)
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
                let preferredSize = cell.preferredLayoutSizeFittingWidth(targetWidth: _collectionView.frame.size.width - 6)
                return preferredSize
            }
            return CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if _segmentControl.selectedSegmentIndex == 0 {
            let product: Product = searchViewModel.products[indexPath.row]
            bringUpProductScreen(product: product)
        }
        else {
            let store: Store = searchViewModel.stores[indexPath.row]
            bringUpStoreScreen(store: store)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInset = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
        return edgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func bringUpProductScreen(product: Product) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDProductVC") as! GDProductVC
        controller.product = product
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true);
    }
    
    func bringUpStoreScreen(store: Store) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDStoreVC") as! GDStoreVC
        controller.store = store
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func didFetchData() {
        _collectionView.reloadData()
    }
    
    /*
    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        if _segmentControl.selectedSegmentIndex == 0 {
            
        } else {
            
        }
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }*/
}
