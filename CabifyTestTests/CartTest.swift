//
//  CartTest.swift
//  CabifyTestTests
//
//  Created by Santi on 27/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import XCTest
@testable import CabifyTest

class CartTest: XCTestCase {

    //SUT
    var cart: Cart!
    
    override func setUp() {
        cart = Cart.shared
    }

    override func tearDown() {
        cart.reset()
        cart = nil
    }
    
    func test_add_products() {
        
        let givenProduct = Product(code: .voucher, name: "Voucher", price: 12.0)
        
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        
        XCTAssertEqual(cart.getCurrentProducts().count, 2)
    }
    
    func test_get_current_products() {
        
        let givenProducts = [
            Product(code: .voucher, name: "Voucher", price: 12.0),
            Product(code: .tshirt, name: "TShirt", price: 20.0)
        ]
        cart.currentProducts = givenProducts
        
        let products = cart.getCurrentProducts()
        
        XCTAssertEqual(products, givenProducts)
        
    }
    
    func test_return_total_0_with_zero_products() {
        
        let total = cart.getTotal()
        
        XCTAssertEqual(total, 0)
        
    }
    // *** Next four tests are just with regard to the test app, they are too concrete to production. They are only viable to production when testing bugs *** ///
    func test_return_32_50_when_addings_one_voucher_one_tshirt_one_mug_with_concrete_price() {
        
        let givenVoucher = Product(code: .voucher, name: "Voucher", price: 5, discount: .twoForOne)
        let givenTshirt = Product(code: .tshirt, name: "T-Shirt", price: 20, discount: .bulkBuying)
        let givenMug = Product(code: .mug, name: "Mug", price: 7.5, discount: .none)
        
        cart.addProduct(givenVoucher)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenMug)
        
        let expectedTotal = 32.5
        XCTAssertEqual(cart.getTotal(), expectedTotal)
        
    }
    
    func test_return_25_when_adding_two_voucher_one_tshirt_with_contrete_price() {
        
        let givenVoucher = Product(code: .voucher, name: "Voucher", price: 5, discount: .twoForOne)
        let givenTshirt = Product(code: .tshirt, name: "T-Shirt", price: 20, discount: .bulkBuying)
        
        cart.addProduct(givenVoucher)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenVoucher)
        
        let expectedTotal = 25.0
        XCTAssertEqual(cart.getTotal(), expectedTotal)
    }
    
    func test_return_81_when_adding_four_tshirt_and_one_voucher_with_concrete_price() {
        
        let givenVoucher = Product(code: .voucher, name: "Voucher", price: 5, discount: .twoForOne)
        let givenTshirt = Product(code: .tshirt, name: "T-Shirt", price: 20, discount: .bulkBuying)
        
        cart.addProduct(givenTshirt)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenVoucher)
        
        let expectedTotal = 81.0
        XCTAssertEqual(cart.getTotal(), expectedTotal)
    }
    
    func test_74_50_when_adding_three_voucher_three_tshirt_and_one_with_concrete_price() {
        let givenVoucher = Product(code: .voucher, name: "Voucher", price: 5, discount: .twoForOne)
        let givenTshirt = Product(code: .tshirt, name: "T-Shirt", price: 20, discount: .bulkBuying)
        let givenMug = Product(code: .mug, name: "Mug", price: 7.5, discount: .none)
        
        cart.addProduct(givenVoucher)
        cart.addProduct(givenVoucher)
        cart.addProduct(givenVoucher)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenMug)
        
        
        let expectedTotal = 74.5
        XCTAssertEqual(cart.getTotal(), expectedTotal)
    }
    
    //**** End four croncrete tests ****///
    
    func test_do_not_apply_2_x_1_discount_one_product_return_total_with_no_discount() {
        
        let givenPrice = 10.0
        let givenProduct = Product(code: .voucher, name: "Voucher", price: givenPrice, discount: .twoForOne)
        
        cart.addProduct(givenProduct)
        
        XCTAssertEqual(cart.getTotal(), givenPrice)
    }

    func test_apply_2_x_1_discount_even_products_count_return_half_total() {
        
        let givenPrice = 10.0
        let givenProduct = Product(code: .voucher, name: "Voucher", price: givenPrice, discount: .twoForOne)
        
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        
        let expectedTotal = (givenPrice * Double(cart.getCurrentProducts().count)) / 2
        XCTAssertEqual(cart.getTotal(), expectedTotal)
        
    }
    
    func test_apply_2_x_1_discount_odd_products_count_return() {
        
        let givenPrice = 10.0
        let givenProduct = Product(code: .voucher, name: "Voucher", price: givenPrice, discount: .twoForOne)
        
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        
        let expectedTotal = ((givenPrice * Double(cart.getCurrentProducts().count - 1)) / 2) + givenPrice
        XCTAssertEqual(cart.getTotal(), expectedTotal)
        
        
    }
    
    func test_not_apply_2_x_1_discount_when_two_different_products_when_same_discount() {
        
        let givenPrice1 = 10.0
        let givenPrice2 = 20.0
        let givenProduct1 = Product(code: .voucher, name: "Voucher", price: givenPrice1, discount: .twoForOne)
        let givenProduct2 = Product(code: .tshirt, name: "T-Shirt", price: givenPrice2, discount: .twoForOne)
        
        cart.addProduct(givenProduct1)
        cart.addProduct(givenProduct2)
        
        let expectedTotal = givenPrice1 + givenPrice2
        XCTAssertEqual(cart.getTotal(), expectedTotal)
    }

    
    func test_apply_bulk_discount_when_adding_greater_or_equal_three_products() {
        let givenPrice = 30.0
        let givenCode = Product.Code.tshirt
        let givenProduct = Product(code: givenCode, name: "T-Shirt", price: givenPrice, discount: .bulkBuying)
        
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        
        let expectedTotal = (givenPrice * Double(cart.getCurrentProducts().count)) - (givenCode.totalDiscounted * Double(cart.getCurrentProducts().count))
        XCTAssertEqual(cart.getTotal(), expectedTotal)
        
    }
    
    func test_do_not_apply_bulk_discount_when_adding_less_than_three_products() {
        let givenPrice = 30.0
        let givenCode = Product.Code.tshirt
        let givenProduct = Product(code: givenCode, name: "T-Shirt", price: givenPrice, discount: .bulkBuying)
        
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        
        let expectedTotal = (givenPrice * Double(cart.getCurrentProducts().count))
        XCTAssertEqual(cart.getTotal(), expectedTotal)
    }
    
    func test_clean_current_products_when_clean_called() {
        
        let givenProducts = [
            Product(code: .voucher, name: "Voucher", price: 12.0),
            Product(code: .tshirt, name: "TShirt", price: 20.0)
        ]
        cart.currentProducts = givenProducts
        
        cart.clean()
        
        XCTAssertTrue(cart.getCurrentProducts().isEmpty)
    }
    
    func test_discounted_total_for_bulk_buying() {
        
        let givenPrice = 30.0
        let givenCode = Product.Code.tshirt
        let givenProduct = Product(code: givenCode, name: "T-Shirt", price: givenPrice, discount: .bulkBuying)
        
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        
        let expectedDiscountedTotal = givenCode.totalDiscounted * Double(cart.currentProducts.count)
        XCTAssertEqual(cart.getDiscountedTotal(), expectedDiscountedTotal)
    }
    
    func test_discounted_total_for_2_x_1() {
        
        let givenPrice = 10.0
        let givenProduct = Product(code: .voucher, name: "Voucher", price: givenPrice, discount: .twoForOne)
        
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        cart.addProduct(givenProduct)
        
        let expectedDiscountedTotal = (givenPrice * Double(cart.getCurrentProducts().count)) / 2
        XCTAssertEqual(cart.getDiscountedTotal(), expectedDiscountedTotal)
        
    }
    
    func test_return_summary_from_current_products() {
        
        let givenVoucher = Product(code: .voucher, name: "Voucher", price: 5, discount: .twoForOne)
        let givenTshirt = Product(code: .tshirt, name: "T-Shirt", price: 20, discount: .bulkBuying)
        let givenMug = Product(code: .mug, name: "Mug", price: 7.5, discount: .none)
        
        cart.addProduct(givenVoucher)
        cart.addProduct(givenVoucher)
        cart.addProduct(givenVoucher)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenTshirt)
        cart.addProduct(givenMug)
        
        let summary = cart.getSummary()
        XCTAssertEqual(summary.products.count, 3)
        XCTAssertEqual(summary.discountedTotal, cart.getDiscountedTotal())
        
    }
}

extension Cart {
    func reset() {
        currentProducts = []
    }
}


