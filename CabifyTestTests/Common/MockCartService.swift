//
//  MockCart.swift
//  CabifyTestTests
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
@testable import CabifyTest

class MockCartService: CartService {
    
    var givenTotal = 0.0
    var givenProducts: [Product] = []
    
    var addProductCalled = false
    var cleanCalled = false
    
    func addProduct(_ product: Product) {
        addProductCalled = true
    }
    
    func getTotal() -> Double {
        return givenTotal
    }
    
    func getCurrentProducts() -> [Product] {
        return givenProducts
    }
    
    func clean() {
        cleanCalled = true
    }
}
