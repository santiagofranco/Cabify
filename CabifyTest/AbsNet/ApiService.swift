//
//  ApiService.swift
//  AbsNet
//
//  Created by Santiago Franco García on 23/5/18.
//  Copyright © 2018 Santiago Franco. All rights reserved.
//

import Foundation

public class ApiService {
    
    public static let shared = ApiService()
    
    var configuration: AbsNetConfiguration? = nil
    
    public static func with(configuration: AbsNetConfiguration) {
        ApiService.shared.configuration = configuration
    }
    
    private init(){}
}
