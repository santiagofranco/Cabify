//
//  ProductListPresenter.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

/**
 
 Presenter contains all the presentation logic and decisions of the product list module.
 Presenter doesn't need a protocol for two reasons:
 1. We are not injecting this class anywhere. We are not going to break any dependency if we change something in this class.
 2. Any change of logic likely will cause changes in all dependencies.
 
 */

class ProductListPresenter {
    
    let view: ProductListViewProtocol
    let interactor: ProductListInteractorProtocol
    let router: ProductListRouterProtocol
    let reachability: ReachabilityService
    let cart: CartService
    
    init(view: ProductListViewProtocol, interactor: ProductListInteractorProtocol, router: ProductListRouterProtocol, reachability: ReachabilityService, cart: CartService) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.reachability = reachability
        self.cart = cart
        
        self.view.delegate = self
        self.interactor.delegate = self
    }
    
    fileprivate func loadProducts() {
        guard reachability.isReachable() else {
            view.showNoInternetConnectionError()
            return
        }
        
        view.showLoading()
        interactor.loadProducts()
    }
}

extension ProductListPresenter: ProductListViewDelegate {
    
    func viewDidLoad() {
        loadProducts()
    }
    
    func didTapRefresh() {
        loadProducts()
    }
    
    func didTapRetry() {
        loadProducts()
    }
    
    func didTapProduct(_ product: Product) {
        cart.addProduct(product)
        view.showTotal(cart.getTotal())
        view.enableCheckout()
    }
    
    func didTapPay() {
        interactor.pay(products: cart.getCurrentProducts(), total: cart.getTotal())
    }
    
    func didTapClean() {
        cart.clean()
        view.showTotal(cart.getTotal())
        view.disableCheckout()
    }
    
    func viewDidAppear() {
        let total = cart.getTotal()
        view.showTotal(total)
        
        if total > 0 {
            view.enableCheckout()
            return
        }
        view.disableCheckout()
    }
}

extension ProductListPresenter: ProductListInteractorDelegate {
    
    func didLoadProducts(_ products: [Product]) {
        view.showProducts(products)
        view.hideLoading()
    }
    
    func didLoadProductsError(_ error: CabError) {
        view.hideLoading()
        switch error {
        case .data:
            view.showDataErrorMessage()
            return
        case .unauthorized:
            router.goToLogin(from: view)
            return
        default:
            return
        }
        
    }
    
    func didPaymentSuccess() {
        router.goToSummary(from: view)
    }
    
    func didPaymentError(_ error: CabError) {
        switch error {
        case .notEnoughBalance:
            view.showNotEnoughBalanceError()
            return
        case .unauthorized:
            router.goToLogin(from: view)
            return
        default:
            return
        }
    }
}
