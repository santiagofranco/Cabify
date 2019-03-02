//
//  ProductListRouter.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import UIKit


/**
 This class makes the navigation to other screens.
 
 We use a protocol for this class, because we are injecting this implementation in the presenter.
 We can change easily this implementation without break nothing.
 */

class ProductListRouter: ProductListRouterProtocol {
    
    func goToLogin(from view: ProductListViewProtocol) {
        // This method is just an example for test
    }
    
    func goToSummary(from view: ProductListViewProtocol) {
        guard let view = view as? UIViewController else {
            return
        }
        
        view.present(SummaryModule().provide(), animated: true, completion: nil)
    }
}
