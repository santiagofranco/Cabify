//
//  SummaryContract.swift
//  CabifyTest
//
//  Created by Santi on 01/03/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

/**
 
 This file contains all the protocols for the summary module of the app
 The goal of the contract file is to see in just a glance all of the functionality of the module
 Also, having all protocols in one file let us to change any implementation file/class easily, just creating a new one and deleting the old one
 */

protocol SummaryViewProtocol: class {
    var delegate: SummaryViewDelegate? { get set }
    
    func showProducts(_ products: [ProductSummary])
    func showTotalDiscounted(_ total: Double)
}

protocol SummaryViewDelegate: class {
    func viewDidLoad()
    func didTapClose()
}
