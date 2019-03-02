//
//  SummaryContract.swift
//  CabifyTest
//
//  Created by Santi on 01/03/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

protocol SummaryViewProtocol: class {
    var delegate: SummaryViewDelegate? { get set }
    
    func showProducts(_ products: [ProductSummary])
    func showTotalDiscounted(_ total: Double)
}

protocol SummaryViewDelegate: class {
    func viewDidLoad()
    func didTapClose()
}
