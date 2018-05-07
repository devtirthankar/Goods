//
//  GDProductCart.swift
//  Goods
//
//  Created by nabanita on 04/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

class GDCartManager: NSObject {
    
    var cart = [Product]()
    
    static let sharedManager: GDCartManager = {
        let instance = GDCartManager()
        return instance
    }()
    
    override init(){
        super.init()
    }
    
    func addProductToCart(product: Product) {
        cart.append(product)
    }
    
    func removeProductFromCart(product: Product) {
        cart.remove(object: product)
    }
}
