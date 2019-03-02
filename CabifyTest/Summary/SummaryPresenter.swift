//
//  SummaryPresenter.swift
//  CabifyTest
//
//  Created by Santi on 01/03/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

/**
 
 Presenter contains all the presentation logic and decisions of the summary module.
 Presenter doesn't need a protocol for two reasons:
 1. We are not injecting this class anywhere. We are not going to break any dependency if we change something in this class.
 2. Any change of logic likely will cause changes in all dependencies.
 
 */

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
