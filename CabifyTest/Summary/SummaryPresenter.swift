//
//  SummaryPresenter.swift
//  CabifyTest
//
//  Created by Santi on 01/03/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

class SummaryPresenter {
    
    let view: SummaryViewProtocol
    let cart: CartService
    
    init(view: SummaryViewProtocol, cart: CartService) {
        self.view = view
        self.cart = cart
        
    }
}

extension SummaryPresenter: SummaryViewDelegate {
    
    func viewDidLoad() {
        let summary = cart.getSummary()
        view.showProducts(summary.products)
        view.showTotalDiscounted(summary.discountedTotal)
    }
    
    func didTapClose() {
        cart.clean()
    }
}
