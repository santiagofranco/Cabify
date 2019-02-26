//
//  Configuration.swift
//  AbsNet
//
//  Created by Santiago Franco García on 23/5/18.
//  Copyright © 2018 Santiago Franco. All rights reserved.
//

import Foundation

public struct AbsNetConfiguration {
    public let url: String
    public let jwt: String?
    
    public init(url: String, jwt: String? = nil) {
        self.url = url
        self.jwt = jwt
    }
    
}
