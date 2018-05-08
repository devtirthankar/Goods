//
//  GDStoreViewModel.swift
//  Goods
//
//  Created by nabanita on 08/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
protocol GDStoreViewModelDelegate {
    func didFetchData()
}

class GDStoreViewModel {
    var delegate: GDStoreViewModelDelegate?
    var products = [Product]()
    
    //MARK: Fetch Data
    func fetchProductsForStore(storeId: Int64) {
        GDWebServiceManager.sharedManager.getProductsForStore(storeId: storeId, block: {[weak self](response, error) in
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
