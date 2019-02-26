//
//  ProductListInteractor.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

class ProductListInteractor: ProductListInteractorProtocol {
    
    weak var delegate: ProductListInteractorDelegate?
    
    let getProductsUseCase = GetProductosUseCase()
    
    func loadProducts() {
        getProductsUseCase.success = { [weak self] output in
            
            guard let outputProducts = output?.products else {
                self?.delegate?.didLoadProductsError(.data)
                return
            }
            
            let products = outputProducts.map {
                return Product(code: $0.code, name: $0.name, price: $0.price)
            }
            
            self?.delegate?.didLoadProducts(products)
        }
        
        getProductsUseCase.failure = { [weak self] error in
            //Here we should map api error to our logic error, unauthorized is just an example
            self?.delegate?.didLoadProductsError(.unauthorized)
        }
        
        getProductsUseCase.execute()
    }
    
    func pay(products: [Product], total: Double) {
        self.delegate?.didPaymentSuccess()
        //self.delegate?.didPaymentError(.notEnoughBalance)
    }
    
}
