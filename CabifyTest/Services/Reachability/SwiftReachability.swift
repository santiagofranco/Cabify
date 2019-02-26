//
//  SwiftReachability.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
import Reachability

class SwiftReachabilityService: ReachabilityService {
    
    private let reachability = Reachability()!
    
    func isReachable() -> Bool {
        return reachability.connection != .none
    }
    
}
