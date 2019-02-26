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
}

protocol ProductListViewDelegate: class {
    
    func viewDidLoad()
    
}

protocol ProductListInteractorProtocol: class {
    var delegate: ProductListInteractorDelegate? { get set }
    
    func loadProducts() 
}

protocol ProductListInteractorDelegate: class {
    
    func didLoadProducts(_ products: [Product])
    func didLoadProductsError(_ error: CabError)
}

protocol ProductListRouterProtocol: class {
    
    func goToLogin(from view: ProductListViewProtocol)
}
