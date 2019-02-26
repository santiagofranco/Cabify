//
//  CabError.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

enum CabError: Error {
    case unauthorized
    case data
    
    //Payments
    case notEnoughBalance
}
