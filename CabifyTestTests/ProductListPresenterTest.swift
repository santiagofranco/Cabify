//
//  ProductListPresenterTest.swift
//  CabifyTestTests
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import XCTest
@testable import CabifyTest

class ProductListPresenterTest: XCTestCase {

    //SUT
    var presenter: ProductListPresenter!
    
    //Mocks
    private var view: MockProductListView!
    private var interactor: MockProductListInteractor!
    private var router: MockProductListRouter!
    private var reachability: MockReachabilityService!
    
    override func setUp() {
        
        view = MockProductListView()
        interactor = MockProductListInteractor()
        router = MockProductListRouter()
        reachability = MockReachabilityService()
        
        presenter = ProductListPresenter(view: view, interactor: interactor, router: router ,reachability: reachability)
        
    }

    override func tearDown() {
        view = nil
        interactor = nil
        presenter = nil
    }
    
    func test_show_no_internet_error_when_view_did_loaded_and_device_hasnt_internet_connection() {
        
        reachability.givenReachable = false
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showNoInternetConnectionErrorCalled)
        XCTAssertFalse(view.showLoadingCalled)
        
    }
    
    func test_show_loading_when_view_did_load() {
        
        reachability.givenReachable = true
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertFalse(view.showNoInternetConnectionErrorCalled)
        
    }
    
    func test_load_products_when_view_did_load() {
        
        reachability.givenReachable = true
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(interactor.loadProductsCalled)
        XCTAssertFalse(view.showNoInternetConnectionErrorCalled)
    }
    
    func test_show_products_when_load_products_success() {
        
        let givenProducts = self.givenProducts()
        
        presenter.didLoadProducts(givenProducts)
        
        XCTAssertTrue(view.showProductsCalled)
        XCTAssertEqual(view.products.count, givenProducts.count)
    }
    
    func test_go_to_login_when_load_product_fails_with_unauthorized_error() {
        
        let givenError: CabError = .unauthorized
        
        presenter.didLoadProductsError(givenError)
        
        XCTAssertTrue(router.goToLoginCalled)
        XCTAssertFalse(view.showDataErrorMessageCalled)
        
    }
    
    func test_show_data_error_when_load_products_fails_with_data_error() {
        
        let givenError: CabError = .data
        
        presenter.didLoadProductsError(givenError)
        
        XCTAssertTrue(view.showDataErrorMessageCalled)
        XCTAssertFalse(router.goToLoginCalled)
        
    }
    
    func test_hide_loading_when_load_products_success() {
        
        presenter.didLoadProducts(givenProducts())
        
        XCTAssertTrue(view.hideLoadingCalled)
    }
    
    func test_hide_loading_when_load_products_fails() {
        
        let givenError: CabError = .data
        
        presenter.didLoadProductsError(givenError)
        
        XCTAssertTrue(view.hideLoadingCalled)
    }
    
    func test_show_no_internet_error_when_user_taps_refresh_and_device_hasnt_internet_connection() {
        
        reachability.givenReachable = false
        
        presenter.didTapRefresh()
        
        XCTAssertTrue(view.showNoInternetConnectionErrorCalled)
        XCTAssertFalse(view.showLoadingCalled)
        
    }
    
    func test_show_loading_when_user_taps_refresh() {
        
        reachability.givenReachable = true
        
        presenter.didTapRefresh()
        
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertFalse(view.showNoInternetConnectionErrorCalled)
        
    }
    
    func test_load_products_when_user_taps_refresh() {
        
        reachability.givenReachable = true
        
        presenter.didTapRefresh()
        
        XCTAssertTrue(interactor.loadProductsCalled)
        XCTAssertFalse(view.showNoInternetConnectionErrorCalled)
    }
    
    fileprivate func givenProducts() -> [Product] {
        return [
            Product(code: "VOUCHER", name: "Voucher", price: 5),
            Product(code: "TSHIRT", name: "T-Shirt", price: 20),
            Product(code: "MUG", name: "Mug", price: 7.5)
        ]
    }

    private class MockProductListView: ProductListViewProtocol {
        weak var delegate: ProductListViewDelegate?
        
        var showNoInternetConnectionErrorCalled = false
        var showLoadingCalled = false
        var showProductsCalled = false
        var products: [Product] = []
        var showDataErrorMessageCalled = false
        var hideLoadingCalled = false
        
        func showNoInternetConnectionError() {
            showNoInternetConnectionErrorCalled = true
        }
        
        func showLoading() {
            showLoadingCalled = true
        }
        
        func showProducts(_ products: [Product]) {
            showProductsCalled = true
            self.products = products
        }
        
        func showDataErrorMessage() {
            showDataErrorMessageCalled = true
        }
        
        func hideLoading() {
            hideLoadingCalled = true
        }
    }
    
    private class MockProductListInteractor: ProductListInteractorProtocol {
        weak var delegate: ProductListInteractorDelegate?
        
        var loadProductsCalled = false
        
        func loadProducts() {
            loadProductsCalled = true
        }
    }
    
    private class MockProductListRouter: ProductListRouterProtocol {
        
        var goToLoginCalled = false
        
        func goToLogin(from view: ProductListViewProtocol) {
            goToLoginCalled = true
        }
    }
    
    
    
}
