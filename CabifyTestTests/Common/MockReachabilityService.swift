//
//  MockReachabilityService.swift
//  CabifyTestTests
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation
@testable import CabifyTest

class MockReachabilityService: ReachabilityService {
    
    var givenReachable = false
    
    func isReachable() -> Bool {
        return givenReachable
    }
}
