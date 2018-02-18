//
//  GDMyCartVC.swift
//  Goods
//
//  Created by Nabanita on 19/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import Foundation
import UIKit

class GDMyCartVC: GDBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    @IBOutlet weak var _continueShoppingBttn: UIButton!
    @IBOutlet weak var _proceedToCheckoutBttn: UIButton!
    @IBOutlet weak var _cartSummeryView: UIView!
    
    let cellReuseIdentifier = "GDMyCartItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForTitleViews()
        
        // Do any additional setup after loading the view.
        _collectionView.register(UINib.init(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        configureUI()
    }
    
    func configureUI() {
        
        _continueShoppingBttn.layer.cornerRadius = _continueShoppingBttn.frame.height * 0.5
        _proceedToCheckoutBttn.layer.cornerRadius = _proceedToCheckoutBttn.frame.height * 0.5
        _proceedToCheckoutBttn.layer.borderWidth = 1.0
        _proceedToCheckoutBttn.layer.borderColor = UIColor.colorForHex(GDColor.ThemeColor as NSString).cgColor  //UIColor.init(colorLiteralRed: 41.0/256.0, green: 190.0/256.0, blue: 136.0/256.0, alpha: 1.0).cgColor
        _proceedToCheckoutBttn.setTitleColor(UIColor.colorForHex(GDColor.ThemeColor as NSString), for: .normal)
        let layer = _cartSummeryView.layer
        layer.masksToBounds = true
        layer.cornerRadius = 6.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.5
        _cartSummeryView.clipsToBounds = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        let cell: GDMyCartItemCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GDMyCartItemCell
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  _collectionView.frame.size.width
        let height = width * 0.5//(3 / 4)
        return CGSize.init(width: width, height: height)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let edgeInset = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
        return edgeInset
    }

}
