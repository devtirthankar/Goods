//
//  GDNearYouVC.swift
//  Goods
//
//  Created by Tirthankar on 08/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDNearYouVC: GDBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GDStoreContainerCellDelegate, GDNearYouViewModelDelegate {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    
    var nearYouViewModel = GDSNearYouViewModel()
    lazy var _refreshControl = UIRefreshControl()
    var _isRefreshing = false
    var userLatitude = 21.510472500000017
    var userLongitude = 39.16535546874998
    let cellReuseIdentifier = "GDStoreThumbnailCell"
    let headerReuseIdentifier = "GDNearYouSectionHeaderView"
    let cellReuseIdentifierTopStore = "GDStoreContainerCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorForTitleViews()
        
        if let currentLocation = GDLocationManager.sharedManager.userLocation {
            userLatitude = currentLocation.coordinate.latitude
            userLongitude = currentLocation.coordinate.longitude
        }
        nearYouViewModel.delegate = self
        nearYouViewModel.fetchStores(latitude: userLatitude, longitude: userLongitude)
        nearYouViewModel.fetchTopStores(latitude: 21.510472500000017, longitude: 39.16535546874998)
        
        _collectionView.register(UINib.init(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        _collectionView.register(UINib.init(nibName: cellReuseIdentifierTopStore, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifierTopStore)
        _collectionView.register(UINib.init(nibName: headerReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        _collectionView.alwaysBounceVertical = true
        let layout = _collectionView.collectionViewLayout as? UICollectionViewFlowLayout 
        layout?.sectionHeadersPinToVisibleBounds = true
        _refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        _collectionView.addSubview(_refreshControl)
        _collectionView.alwaysBounceVertical = true
        
    }
    
    func refresh() {
        if _isRefreshing {return}
        DispatchQueue.main.async {
            self._isRefreshing = true
            if let currentLocation = GDLocationManager.sharedManager.userLocation {
                self.userLatitude = currentLocation.coordinate.latitude
                self.userLongitude = currentLocation.coordinate.longitude
            }
            self.userLatitude = 21.510472500000017
            self.userLongitude = 39.16535546874998
            self.nearYouViewModel.fetchStores(latitude: self.userLatitude, longitude: self.userLongitude)
        }
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
    
    @IBAction func cartButtonPressed(_ sender: UIButton){
        if let _ = GDLogin.loggedInUser()?.token {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "GDMyCartVC")
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        }else {
            global.destinationViewType = DestinationViewType.mycart
            bringUpLoginView()
        }
    }
    
    func bringUpLoginView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GDSignInVC")
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        }
        return nearYouViewModel.stores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if indexPath.section == 0 {
            let cell: GDStoreContainerCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifierTopStore, for: indexPath) as! GDStoreContainerCell
            cell.stores = nearYouViewModel.stores
            cell.delegate = self
            return cell
        }
        let store: Store = nearYouViewModel.stores[indexPath.row]
        let cell: GDStoreThumbnailCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GDStoreThumbnailCell
        let storename: String = ((Locale.current.languageCode! == "ar") ? store.storenamear : store.storename)!
        cell.titleLabel.text = storename
        if let imagepath = store.logo {
            let imageURL = GDWebServiceManager.sharedManager.baseImageURL + "\(imagepath)"
            cell.loadThumbImage(url: imageURL)
        }
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
            header._titleLabel.text = "Top Stores".translate
        }else{
            header._titleLabel.text = "Near You".translate
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
            bringUpStoreScreen(indexPath: indexPath)
        }
    }
    
    func bringUpStoreScreen(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GDStoreVC") as! GDStoreVC
        controller.store = nearYouViewModel.stores[indexPath.row]
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true);

    }
    
    //MARK: GDStoreContainerCellDelegate
    func didSelectStoreAtIndexPath(_ indexPath: IndexPath){
        bringUpStoreScreen(indexPath: indexPath)
    }
    
    //MARK: GDNearYouViewModelDelegate
    func didFetchData() {
        _isRefreshing = false
        _refreshControl.endRefreshing()
        _collectionView.reloadData()
    }

}
