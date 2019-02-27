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
    
    var currentProducts: [Product] = []
    
    func addProduct(_ product: Product) {
        currentProducts.append(product)
    }
    
    func getTotal() -> Double {
        var total = 0.0
        
        Product.Code.allCases.forEach { code in
            let products = self.currentProducts.filter { return $0.code == code }
            Discount.allCases.forEach {
                total += $0.getTotalFrom(products: products)
            }
        }
        
        return total
    }
    
    func getCurrentProducts() -> [Product] {
        return currentProducts
    }
}

extension Discount {
   
    func getTotalFrom(products: [Product]) -> Double {
        
        var total = 0.0
        let discountedProducts = products.filter { return $0.discount == self }
        
        switch self {
        case .twoForOne:
            for (index, product) in discountedProducts.enumerated() {
                if index % 2 == 0 {
                    total += product.price
                }
            }
            break
        case .bulkBuying:
            let shouldApplyDiscount = discountedProducts.count >= 3
            discountedProducts.forEach {
                total += shouldApplyDiscount ? $0.price - $0.code.totalDiscounted : $0.price
            }
            
            break
            
        case .none:
            discountedProducts.forEach {
                total += $0.price
            }
        }
        
        return total
    }
    
}

extension Product.Code {
    var totalDiscounted: Double {
        switch self {
        case .voucher, .mug, .none:
            return 2.5
        case .tshirt:
            return 1
        }
        
    }
}

