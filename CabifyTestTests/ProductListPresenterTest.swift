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
    private var cart: MockCartService!
    
    override func setUp() {
        
        view = MockProductListView()
        interactor = MockProductListInteractor()
        router = MockProductListRouter()
        reachability = MockReachabilityService()
        cart = MockCartService()
        
        presenter = ProductListPresenter(view: view, interactor: interactor, router: router ,reachability: reachability, cart: cart)
        
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
    
    func test_show_no_internet_error_when_user_taps_retry_and_device_hasnt_internet_connection() {
        
        reachability.givenReachable = false
        
        presenter.didTapRetry()
        
        XCTAssertTrue(view.showNoInternetConnectionErrorCalled)
        XCTAssertFalse(view.showLoadingCalled)
        
    }
    
    func test_show_loading_when_user_taps_retry() {
        
        reachability.givenReachable = true
        
        presenter.didTapRetry()
        
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertFalse(view.showNoInternetConnectionErrorCalled)
        
    }
    
    func test_load_products_when_user_taps_retry() {
        
        reachability.givenReachable = true
        
        presenter.didTapRetry()
        
        XCTAssertTrue(interactor.loadProductsCalled)
        XCTAssertFalse(view.showNoInternetConnectionErrorCalled)
    }
    
    func test_add_product_to_cart_when_user_taps_product() {
        
        let givenProduct = Product(code: .voucher, name: "Voucher", price: 10)
        
        presenter.didTapProduct(givenProduct)
        
        XCTAssertTrue(cart.addProductCalled)
        
    }
    
    func test_show_total_from_cart_service_when_user_taps_product() {
        
        let givenTotal = 10.0
        cart.givenTotal = givenTotal
        let givenProduct = Product(code: .voucher, name: "Voucher", price: 10)
        
        presenter.didTapProduct(givenProduct)
        
        XCTAssertTrue(view.showTotalCalled)
        XCTAssertEqual(view.totalShown, givenTotal)
        
    }
    
    func test_execute_payment_when_user_taps_on_pay_button() {
        
        let givenTotal = 10.0
        cart.givenTotal = givenTotal
        let givenProducts = self.givenProducts()
        cart.givenProducts = givenProducts
        
        presenter.didTapPay()
        
        XCTAssertTrue(interactor.payCartCalled)
        XCTAssertEqual(interactor.totalToPay, givenTotal)
        XCTAssertEqual(interactor.payProducts.count, givenProducts.count)
        
    }
    
    func test_show_payment_success_message_when_payment_success() {
        
        presenter.didPaymentSuccess()
        
        XCTAssertTrue(view.showPaymentSuccessMessageCalled)
        
    }
    
    func test_show_not_enough_balance_error_when_payment_fails_with_not_enough_balance_error() {
        
        let givenError: CabError = .notEnoughBalance
        
        presenter.didPaymentError(givenError)
        
        XCTAssertTrue(view.showNotEnoughBalanceErrorCalled)
        XCTAssertFalse(router.goToLoginCalled)
        
    }
    
    func test_go_to_login_when_payment_fails_with_unauthorized_error() {
        let givenError: CabError = .unauthorized
        
        presenter.didPaymentError(givenError)
        
        XCTAssertTrue(router.goToLoginCalled)
        XCTAssertFalse(view.showNotEnoughBalanceErrorCalled)
        
    }
    
    func test_go_to_summary_when_user_tap_see_summary_button() {
        
        presenter.didTapSeeSummary()
        
        XCTAssertTrue(router.goToSummaryCalled)
    }
    
    fileprivate func givenProducts() -> [Product] {
        return [
            Product(code: .voucher, name: "Voucher", price: 5),
            Product(code: .tshirt, name: "T-Shirt", price: 20),
            Product(code: .mug
                , name: "Mug", price: 7.5)
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
        var showTotalCalled = false
        var totalShown = 0.0
        var showPaymentSuccessMessageCalled = false
        var showNotEnoughBalanceErrorCalled = false
        
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
        
        func showTotal(_ total: Double) {
            showTotalCalled = true
            totalShown = total
        }
        
        func showPaymentSuccessMessage() {
            showPaymentSuccessMessageCalled = true
        }
        
        func showNotEnoughBalanceError() {
            showNotEnoughBalanceErrorCalled = true
        }
    }
    
    private class MockProductListInteractor: ProductListInteractorProtocol {
        weak var delegate: ProductListInteractorDelegate?
        
        var loadProductsCalled = false
        var payCartCalled = false
        var payProducts: [Product] = []
        var totalToPay = 0.0
        
        func loadProducts() {
            loadProductsCalled = true
        }
        
        func pay(products: [Product], total: Double) {
            payCartCalled = true
            payProducts = products
            totalToPay = total
        }
    }
    
    private class MockProductListRouter: ProductListRouterProtocol {
        
        var goToLoginCalled = false
        var goToSummaryCalled = false
        
        func goToLogin(from view: ProductListViewProtocol) {
            goToLoginCalled = true
        }
        
        func goToSummary(from view: ProductListViewProtocol) {
            goToSummaryCalled = true
        }
    }
    
    
    
}
