//
//  ProductListModule.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import UIKit


/**
 This class makes all the dependecy injection for the module
 */

class ProductListModule {
    
    lazy var view: ProductListViewController = {
        ProductListViewController()
    }()
    
    lazy var interactor: ProductListInteractorProtocol = {
        ProductListInteractor()
    }()
    
    lazy var router: ProductListRouterProtocol = {
        ProductListRouter()
    }()
    
    lazy var reachability: ReachabilityService = {
        SwiftReachabilityService()
    }()
    
    lazy var cart: CartService = {
        return Cart.shared
    }()
    
//    lazy var presenter: ProductListPresenter = {
//        
//    }()
    
    init() {
        
    }
    
    func provide() -> UIViewController {
        let presenter = ProductListPresenter(view: view, interactor: interactor, router: router, reachability: reachability, cart: cart)
        
        view.delegate = presenter
        interactor.delegate = presenter
        return view
    }
    
}
