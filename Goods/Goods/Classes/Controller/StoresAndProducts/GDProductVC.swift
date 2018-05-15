//
//  GDProductVC.swift
//  Goods
//
//  Created by Nabanita on 10/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDProductVC: GDBaseVC, GDProductActionCellDelegate {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    
    let reuseIdentifierCellDescription = "GDProductDescriptionCell"
    let reuseIdentifierHeaderBanner = "GDProductBannerHeader"
    let reuseIdentifierCellAction = "GDProductActionCell"
    
    var product: Product! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        
        _collectionView.register(UINib.init(nibName: reuseIdentifierCellDescription, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierCellDescription)
        _collectionView.register(UINib.init(nibName: reuseIdentifierCellAction, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierCellAction)
         _collectionView.register(UINib.init(nibName: reuseIdentifierHeaderBanner, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifierHeaderBanner)
    }

    @IBAction func backPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}

extension GDProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if indexPath.row == 0 {
            let cell: GDProductDescriptionCell = _collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCellDescription, for: indexPath) as! GDProductDescriptionCell
            cell.descriptionLabel.text = product.productdescription ?? ""
            cell.priceLabel.text = product.price?.description ?? ""
            return cell
        }
        
        let cell: GDProductActionCell = _collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCellAction, for: indexPath) as! GDProductActionCell
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            if let cell = GDProductDescriptionCell.fromNib() {
                cell.descriptionLabel.text = product.productdescription ?? ""
                let preferredSize = cell.preferredLayoutSizeFittingWidth(targetWidth: _collectionView.frame.size.width - 6)
                return preferredSize
            }
        }
        return CGSize.init(width: _collectionView.frame.size.width, height: 250.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInset = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
        return edgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        let header: GDProductBannerHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierHeaderBanner, for: indexPath) as! GDProductBannerHeader
        if let image = product.productimages?[0] {
            let imageURL = GDWebServiceManager.sharedManager.baseImageURL + "\(image.imgpath)"
            header.loadThumbImage(url: imageURL)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 200.0)
    }
    
    //MARK: GDProductActionCellDelegate
    func addProductToCart() {
        GDCartManager.sharedManager.addProductToCart(product: product)
        GDAlertAndLoader.showAlertMessage("Product added to cart")
    }
}

