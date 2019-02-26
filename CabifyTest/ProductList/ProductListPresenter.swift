//
//  ProductListPresenter.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

class ProductListPresenter {
    
    unowned let view: ProductListViewProtocol
    unowned let interactor: ProductListInteractorProtocol
    unowned let router: ProductListRouterProtocol
    unowned let reachability: ReachabilityService
    unowned let cart: CartService
    
    init(view: ProductListViewProtocol, interactor: ProductListInteractorProtocol, router: ProductListRouterProtocol, reachability: ReachabilityService, cart: CartService) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.reachability = reachability
        self.cart = cart
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
    }
    
    func didTapPay() {
        interactor.pay(products: cart.getCurrentProducts(), total: cart.getTotal())
    }
    
    func didTapSeeSummary() {
        router.goToSummary(from: view)
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
        view.showPaymentSuccessMessage()
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
