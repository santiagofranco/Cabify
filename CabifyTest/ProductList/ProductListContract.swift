//
//  ProductListContract.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

protocol ProductListViewProtocol: class {
    var delegate: ProductListViewDelegate? { get set }
    
    func showNoInternetConnectionError()
    func showLoading()
    func showProducts(_ products: [Product])
    func showDataErrorMessage()
    func hideLoading()
    func showTotal(_ total: Double)
    func showNotEnoughBalanceError()
}

protocol ProductListViewDelegate: class {
    
    func viewDidLoad()
    func didTapRefresh()
    func didTapRetry()
    func didTapProduct(_ product: Product)
    func didTapPay()
    func didTapClean()
    func viewDidAppear() 
    
}

protocol ProductListInteractorProtocol: class {
    var delegate: ProductListInteractorDelegate? { get set }
    
    func loadProducts()
    func pay(products: [Product], total: Double)
}

protocol ProductListInteractorDelegate: class {
    
    func didLoadProducts(_ products: [Product])
    func didLoadProductsError(_ error: CabError)
    func didPaymentSuccess()
    func didPaymentError(_ error: CabError)
}

protocol ProductListRouterProtocol: class {
    
    func goToLogin(from view: ProductListViewProtocol)
    func goToSummary(from view: ProductListViewProtocol)
}
