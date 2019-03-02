//
//  SummaryModule.swift
//  CabifyTest
//
//  Created by Santi on 02/03/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import UIKit


/**
 This class makes all the dependecy injection for the module
 */

class SummaryModule {
    
    lazy var view: SummaryViewController = {
        SummaryViewController()
    }()
    
    lazy var cart: CartService = {
        Cart.shared
    }()
    
    func provide() -> UIViewController {
        let presenter = SummaryPresenter(view: self.view, cart: self.cart)
        view.delegate = presenter
        return view
    }
}
