//
//  GDSearchVM.swift
//  Goods
//
//  Created by nabanita on 02/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

protocol GDSearchViewModelDelegate {
    func didFetchData()
}

class GDSearchViewModel {
    var delegate: GDSearchViewModelDelegate?
    var products = [Product]()
    var stores = [Store]()
    
    //MARK: Fetch Data
    func fetchStores() {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.getStores(block: {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            DispatchQueue.main.async {
                guard let data = response as? Data else {
                    print("No product data")
                    return
                }
                
                guard let storelist = try? JSONDecoder().decode(Stores.self, from: data) else {
                    print("Error: Couldn't decode data into Stores")
                    return
                }
                for item in storelist.result {
                    self?.stores.append(item)
                }
                self?.delegate?.didFetchData()
            }
        })
    }
    
    func fetchProducts() {
        GDAlertAndLoader.showLoading()
        GDWebServiceManager.sharedManager.getProducts(block: {[weak self](response, error) in
            GDAlertAndLoader.hideLoading()
            DispatchQueue.main.async {
                guard let data = response as? Data else {
                    print("No product data")
                    return
                }
                
                guard let productlist = try? JSONDecoder().decode(Products.self, from: data ) else {
                    print("Error: Couldn't decode data into Products")
                    return
                }
                for item in productlist.result {
                    self?.products.append(item)
                }
                self?.delegate?.didFetchData()
            }
        })
    }

}
