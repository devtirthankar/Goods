//
//  GDProductVC.swift
//  Goods
//
//  Created by Nabanita on 10/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

class GDProductVC: GDBaseVC {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    
    let reuseIdentifierCellDescription = "GDProductDescriptionCell"
    let reuseIdentifierHeaderBanner = "GDProductBannerHeader"
    let reuseIdentifierCellAction = "GDProductActionCell"
    
    let descrptionText = "One of the finest places to dine A book shop that would give you the word of information. The store has provision for people to sit there and read books and you can buy if you like a few. You get varities of fruits and veggies copared to other shops and the freshness of the products would make you a loyal customer in no time. The best jeweller who provides attractive discounts and EMI options as well. The best branded paints and painting services. One of the finest places to dine. A book shop that would give you the word of information. The store has provision for people to sit there and read books and you can buy if you like a few. You get varities of fruits and veggies copared to other shops and the freshness of the products would make you a loyal customer in no time."
    
    /*let descrptionText = "d dcidc cdhcd dciuhdc cuhdmcuidc diuchdmic diuhcdjc duhmdc dviufhvmifv fuvh fvifhv fvuifhviurthg efopgiyer giuerg rejngeufg weuhv wev ieouwg irue gureiwhg vjwuhvu wuiwh viurwv rwiuhv rwibvn oiu nifn...."*/
    
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
            cell.descriptionLabel.text = descrptionText
            return cell
        }
        
        let cell: GDProductActionCell = _collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCellAction, for: indexPath) as! GDProductActionCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            if let cell = GDProductDescriptionCell.fromNib() {
                
                cell.descriptionLabel.text = descrptionText
                let preferredSize = cell.preferredLayoutSizeFittingWidth(targetWidth: _collectionView.frame.size.width - 6)
                return preferredSize
            }
        }
        return CGSize.init(width: _collectionView.frame.size.width, height: 200.0)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInset = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
        return edgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        let header: GDProductBannerHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierHeaderBanner, for: indexPath) as! GDProductBannerHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 200.0)
    }
}

