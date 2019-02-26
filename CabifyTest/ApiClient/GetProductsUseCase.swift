//
//  GetProductsUseCase.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

class GetProductosUseCase: ApiUseCase<GetProductsUseCaseInput, GetProductsUseCaseOutput> {
    
    override func endpoint(with input: GetProductsUseCaseInput?) -> String {
        return "bins/4bwec"
    }
    
    override func getMethod() -> AbsNetMethod {
        return .get
    }
}

struct GetProductsUseCaseInput: Codable {}

struct GetProductsUseCaseOutput: Codable {
    let products: [GetProductsUseCaseOutputProduct]
}

struct GetProductsUseCaseOutputProduct: Codable {
    let code: String
    let name: String
    let price: Double
}
