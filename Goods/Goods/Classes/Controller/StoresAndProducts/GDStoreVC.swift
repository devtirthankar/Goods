//
//  GDStoreVC.swift
//  Goods
//
//  Created by Nabanita on 10/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDStoreVC: GDBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GDStoreSegmentHeaderDelegate, GDStoreSegmentContainerCellDelegate {
    
    @IBOutlet weak var _collectionView: UICollectionView!

    let headerReuseIdentifierBanner = "GDStoreBannerHeader"
    let headerReuseIdentifierSegment = "GDStoreSegmentHeader"
    let cellReuseIdentifier = "GDStoreSegmentContainerCell"
    var selectedSegment = 0
    var store: Store! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        // Do any additional setup after loading the view.
        
        _collectionView.register(UINib.init(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        _collectionView.register(UINib.init(nibName: headerReuseIdentifierBanner, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifierBanner)
        _collectionView.register(UINib.init(nibName: headerReuseIdentifierSegment, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifierSegment)
        
        let layout = _collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if section == 0 {
            return 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        let cell: GDStoreSegmentContainerCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GDStoreSegmentContainerCell
        cell.configureCollectionViewForSegment(segment: selectedSegment)
        cell.delegate = self
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.section;
        let edgeInsets = self.collectionView(_collectionView, layout: collectionViewLayout, insetForSectionAt: section)
        let totalXEdgeWidth = edgeInsets.left + edgeInsets.right
        
    
        let itemWidth = Double(_collectionView.frame.size.width) - Double(totalXEdgeWidth)
        
        let itemHeight = Double(_collectionView.frame.size.height)
    
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: collectionView.frame.size.width, height: 150.0)
        }else{
            return CGSize.init(width: collectionView.frame.size.width, height: 50.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
    
        if indexPath.section == 0 {
            let header: GDStoreBannerHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifierBanner, for: indexPath) as! GDStoreBannerHeader
            return header
        }else{
            let header: GDStoreSegmentHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifierSegment, for: indexPath) as! GDStoreSegmentHeader
            header.delegate = self
            return header
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInset = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
        return edgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    //MARK: delegate
    func segmentSelectedFor(index: Int) {
        selectedSegment = index
        _collectionView.reloadData()
    }
    
    //MARK: GDStoreSegmentContainerCellDelegate
    func didSelectProductAtIndexPath(_ indexPath: IndexPath){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GDProductVC")
        controller?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
}
