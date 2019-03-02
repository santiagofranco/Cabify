//
//  ProductListRouter.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import UIKit

class ProductListRouter: ProductListRouterProtocol {
    
    func goToLogin(from view: ProductListViewProtocol) {
        //TODO: This method is just an example for test
    }
    
    func goToSummary(from view: ProductListViewProtocol) {
        guard let view = view as? UIViewController else {
            return
        }
        
        view.present(SummaryModule().provide(), animated: true, completion: nil)
    }
}
