//
//  Cart.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

protocol CartService: class {
    func addProduct(_ product: Product)
    func getTotal() -> Double
    func getCurrentProducts() -> [Product]
}

class Cart: CartService {
    
    static let shared = Cart()
    
    private init(){}
    
    private var currentProducts: [Product] = []
    
    func addProduct(_ product: Product) {
        currentProducts.append(product)
    }
    
    func getTotal() -> Double {
        var total = 0.0
        
        currentProducts.forEach {
            total += $0.price
        }
        
        return total //TODO: calculate total applying discounts
    }
    
    func getCurrentProducts() -> [Product] {
        return currentProducts
    }
}

