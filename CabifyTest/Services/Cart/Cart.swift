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
