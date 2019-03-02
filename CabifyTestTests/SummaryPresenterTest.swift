//
//  SummaryPresenterTest.swift
//  CabifyTestTests
//
//  Created by Santi on 01/03/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import XCTest
@testable import CabifyTest

class SummaryPresenterTest: XCTestCase {
    
    //SUT
    var presenter: SummaryPresenter!
    
    //Mocks
    private var view: MockSummaryView!
    private var cart: MockCartService!
    
    override func setUp() {
        
        view = MockSummaryView()
        cart = MockCartService()
        
        presenter = SummaryPresenter(view: view, cart: cart)
    }
    
    override func tearDown() {
        view = nil
        cart = nil
        presenter = nil
    }
    
    func test_show_current_products_when_view_did_load() {
        
        let givenProducts = [
            ProductSummary(name: "Voucher", count: 2, total: 5),
            ProductSummary(name: "TShirt", count: 2, total: 5)
        ]
        let givenSummary = Summary(products: givenProducts, discountedTotal: 10.0)
        cart.givenSummary = givenSummary
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showProductsCalled)
        XCTAssertEqual(view.products, givenProducts)
        
    }
    
    func test_show_total_discounted_when_view_did_load() {
        
        let givenTotal = 10.0
        let givenSummary = Summary(products: [], discountedTotal: givenTotal)
        cart.givenSummary = givenSummary
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showTotalCalled)
        XCTAssertEqual(view.total, givenTotal)
    }
    
    func test_clean_cart_when_user_taps_close() {
        
        presenter.didTapClose()
        
        XCTAssertTrue(cart.cleanCalled)
        
    }

    func test_show_payment_success_message_when_view_did_load() {
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showPaymentSuccessMessageCalled)
    }
    
    fileprivate func givenProducts() -> [Product] {
        return [
            Product(code: .voucher, name: "Voucher", price: 5),
            Product(code: .tshirt, name: "T-Shirt", price: 20),
            Product(code: .mug
                , name: "Mug", price: 7.5)
        ]
    }
    
    private class MockSummaryView: SummaryViewProtocol {
        weak var delegate: SummaryViewDelegate?
        
        var showProductsCalled = false
        var products: [ProductSummary] = []
        var showTotalCalled = false
        var total: Double = 0.0
        var showPaymentSuccessMessageCalled = false
        
        func showProducts(_ products: [ProductSummary]) {
            showProductsCalled = true
            self.products = products
        }
        
        func showTotalDiscounted(_ total: Double) {
            showTotalCalled = true
            self.total = total
        }
        
        func showPaymentSuccessMessage() {
            showPaymentSuccessMessageCalled = true
        }
        
    }
    
}
