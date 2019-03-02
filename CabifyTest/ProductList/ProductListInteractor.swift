//
//  ProductListInteractor.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation


/**
 
 This class contains all the access to data needed in this module.
 We use a protocol for this class, because we are injecting this implementation in the presenter.
 We can change easily this implementation without break nothing.
 
 */

class ProductListInteractor: ProductListInteractorProtocol {
    
    weak var delegate: ProductListInteractorDelegate?
    
    let getProductsUseCase = GetProductosUseCase()
    
    func loadProducts() {
        getProductsUseCase.success = { [weak self] output in
            
            guard let outputProducts = output?.products else {
                self?.delegate?.didLoadProductsError(.data)
                return
            }
            
            let products = outputProducts.map { product -> Product in
                
                //Discount type should come from backend in order to have scalable and maintainable code
                var discount: Discount? = nil
                switch product.code {
                case "VOUCHER":
                    discount = .twoForOne
                case "TSHIRT":
                    discount = .bulkBuying
                default:
                    break
                }
                
                return Product(
                    code: Product.Code(rawValue: product.code) ?? .none,
                    name: product.name,
                    price: product.price,
                    discount: discount)
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
