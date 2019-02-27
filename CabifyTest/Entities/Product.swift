//
//  Product.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

struct Product: Equatable {
    
    enum Code: String, CaseIterable {
        case voucher = "VOUCHER"
        case tshirt = "TSHIRT"
        case mug = "MUG"
        case none = ""
    }
    
    let code: Code
    let name: String
    let price: Double
    let discount: Discount
    
    init(code: Code, name: String, price: Double, discount: Discount? = nil) {
        self.code = code
        self.name = name
        self.price = price
        self.discount = discount ?? .none
    }
}
