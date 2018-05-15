//
//  GDProductCart.swift
//  Goods
//
//  Created by nabanita on 04/05/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

struct CartItem {
    let product: Product
    var itemQuantity: Int
    mutating func increaseItemQuantity(number: Int) {
        itemQuantity = number
    }
}

class GDCartManager: NSObject {
    
    var cart = [CartItem]()
    
    static let sharedManager: GDCartManager = {
        let instance = GDCartManager()
        return instance
    }()
    
    override init(){
        super.init()
    }
    
    func addProductToCart(product: Product) {
        
        var isItemExisting = false
        for index in 0..<cart.count {
            let item = cart[index]
            if item.product.productid == product.productid {
                cart[index].itemQuantity += 1
                isItemExisting = true
            }
        }
        if isItemExisting == false {
            let newItem = CartItem(product: product, itemQuantity: 1)
            cart.append(newItem)
        }
        
    }
    
    func removeProductFromCart(product: Product) -> (status: Bool, price: Float) {
        var price = Float(0.0)
        for index in 0..<cart.count {
            let item = cart[index]
            if item.product.productid == product.productid {
                price = product.price! * Float(item.itemQuantity)
                cart.remove(at: index)
                return (true, price)
            }
        }
        return (false, price)
        //cart.remove(object: product)
    }
    
    //Is called when + or - button is pressed
    func updateProductQuantity(product: Product, increaseItemCount: Bool) {
        for index in 0..<cart.count {
            let item = cart[index]
            if item.product.productid == product.productid {
                if increaseItemCount == true {
                    cart[index].itemQuantity += 1
                } else {
                    if cart[index].itemQuantity>1{
                        cart[index].itemQuantity -= 1
                    }
                }
            }
        }
    }
}
