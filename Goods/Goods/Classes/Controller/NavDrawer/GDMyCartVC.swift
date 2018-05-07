//
//  GDMyCartVC.swift
//  Goods
//
//  Created by Nabanita on 19/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import Foundation
import UIKit

class GDMyCartVC: GDBaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GDMyCartItemCellDelegate {
    
    @IBOutlet weak var _collectionView: UICollectionView!
    @IBOutlet weak var _continueShoppingBttn: UIButton!
    @IBOutlet weak var _proceedToCheckoutBttn: UIButton!
    @IBOutlet weak var _cartSummeryView: UIView!
    @IBOutlet weak var _totalPriceLabel: UILabel!
    var _totalPrice = Float(0.0)
    
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
        
        updateCartPrice()
    }
    
    func updateCartPrice() {
        for item in GDCartManager.sharedManager.cart {
            let price = item.price
            _totalPrice = _totalPrice + price!
        }
        _totalPriceLabel.text = "\(_totalPrice)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkoutButtonPressed(_ sender: UIButton) {
        //Make API call here
    }
    @IBAction func continueShoppingButtonPressed(_ sender: UIButton) {
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return GDCartManager.sharedManager.cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        let cell: GDMyCartItemCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GDMyCartItemCell
        cell.delegate = self
        let serailNo = indexPath.row + 1
        cell._serialNumber.text = "\(serailNo)"
        cell.configureProduct(product: GDCartManager.sharedManager.cart[indexPath.row])
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  _collectionView.frame.size.width
        let height = CGFloat(125.0)//width * 0.5//(3 / 4)
        return CGSize.init(width: width, height: height)
    }
    
    func increaseCartValue(price: Float) {
        _totalPrice = _totalPrice + price
        _totalPriceLabel.text = "\(_totalPrice)"
    }
    func decreaseCartValue(price: Float) {
        _totalPrice = _totalPrice - price
        _totalPriceLabel.text = "\(_totalPrice)"
    }
    
}
