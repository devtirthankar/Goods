//
//  GDOrdersHistoryVC.swift
//  Goods
//
//  Created by Tirthankar M on 09/06/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

class GDOrdersHistoryVC: GDBaseVC {

    @IBOutlet weak var _collectionView: UICollectionView!
    let cellReuseIdentifier = "GDOrderHistoryCell"
    var orders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setColorForTitleViews()
        setFlipViewForLanguage()
        _collectionView.register(UINib.init(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        getOrderHistory()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        if global.destinationViewType == DestinationViewType.orders {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if(aViewController is GDNearYouVC || aViewController is GDSearchVC || aViewController is GDMapViewVC){
                    global.destinationViewType = DestinationViewType.dashboard
                    self.navigationController!.popToViewController(aViewController, animated: true)
                    return
                }
            }
        }else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getOrderHistory() {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.getOrders(block: {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            if let err = error {
                //GDAlertAndLoader.showAlertMessage(err.localizedDescription)
                print("\(err.localizedDescription)")
            }
            else {
                DispatchQueue.main.async {
                    guard let data = response as? Data else {
                        print("No product data")
                        return
                    }
                    guard let orderlist = try? JSONDecoder().decode(Orders.self, from: data ) else {
                        print("Error: Couldn't decode data into Products")
                        return
                    }
                    for item in orderlist.result {
                        self?.orders.append(item)
                    }
                    self?._collectionView.reloadData()
                }
            }
        })
    }
}

extension GDOrdersHistoryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let order: Order = orders[indexPath.row]
        let cell: GDOrderHistoryCell = _collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GDOrderHistoryCell
        cell.orderNumber.text = "Order Number:".translate + "#\(String(describing: order.orderid))"
        cell.productName.text = order.product.productname
        cell.quantity.text = "Quantity:".translate + "\(String(describing: order.quantity!))"
        cell.orderDate.text = ""
        cell.price.text = "Order Status:".translate + "\(String(describing: (order.orderstatus?.orderstatusname!)!))"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  _collectionView.frame.size.width
        let height = CGFloat(115.0)//width * 0.5//(3 / 4)
        return CGSize.init(width: width, height: height)
    }
    
    
}
