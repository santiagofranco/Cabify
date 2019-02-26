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
    
    init(view: ProductListViewProtocol, interactor: ProductListInteractorProtocol, router: ProductListRouterProtocol, reachability: ReachabilityService) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.reachability = reachability
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
        }
        
    }
    
}
