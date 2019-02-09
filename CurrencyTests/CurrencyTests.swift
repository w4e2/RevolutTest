//
//  CurrencyTests.swift
//  CurrencyTests
//
//  Created by pc on 09/02/19.
//  Copyright © 2019 Teste. All rights reserved.
//

import XCTest
@testable import Currency
class CurrencyTests: XCTestCase {
    var currencyManager: CurrencyManager!
    var dictResponce: [String:Any]!
    var dictUpdate: [String:Any]!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        currencyManager = CurrencyManager()
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "jsonResponse", withExtension: "json")
        let urlUpdate = testBundle.url(forResource: "jsonUpdate", withExtension: "json")
        if let data: Data = NSData(contentsOf: url!) as Data? {
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: Any] {
                    self.dictResponce = dictionary
                }
                
            } catch  {
                print("Not parsed")
            }
        }
        if let data: Data = NSData(contentsOf: urlUpdate!) as Data? {
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: Any] {
                    self.dictUpdate = dictionary
                }
                
            } catch  {
                print("Not parsed")
            }
        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        currencyManager = nil
        dictUpdate = nil
        dictResponce = nil
    }
    func testGetPresentationModel() {
        let tempResult = ApiResult(object: dictResponce)
        currencyManager.updateRates(responce: tempResult)
        currencyManager.updateCurrencyAmount(value: 100.0, updateUI: false)
        let presentation = currencyManager.getCurrencyPresentitonModel(position: 3)
        
        let code = currencyManager.rates?.codes[3] ?? .other
        let value = currencyManager.rates?.dictRates[code]!
        let selectedItem = currencyManager.rates?.codes.first!
        let selectedValue = currencyManager.rates?.dictRates[selectedItem!]!
        
        
        let testValue = (value!*100.0/selectedValue!).convertToCurrencyString(code: code)
        XCTAssertEqual(presentation.code, code, "testGetPresentationModel - code value wrong")
        XCTAssertEqual(presentation.value, testValue, "testGetPresentationModel - value value wrong")
        XCTAssertEqual(presentation.currencyName, code.currencyName(), "testGetPresentationModel - currencyName value wrong")


    }
    func testUpdateCurrencyAmount() {
        currencyManager.updateCurrencyAmount(value: 100.0, updateUI: false)
        XCTAssertEqual(currencyManager.currencyAmount, 100.0, "update currency wrong")

    }
    func testRatesUpdate() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let tempResult = ApiResult(object: dictResponce)
        currencyManager.updateRates(responce: tempResult)
        let thirdCode = currencyManager.rates?.codes[3]
        currencyManager.changeBaseRate(position: 3)

        
        XCTAssertEqual(currencyManager.rates!.codes.first, thirdCode, "rates update wrpng")
        
    }
    func testRatesCreation() {
        let tempResult = ApiResult(object: dictResponce)
        currencyManager.updateRates(responce: tempResult)
        
        XCTAssertEqual(currencyManager.rates!.codes.count, 33, "codes list quantity unexpected")
        XCTAssertEqual(currencyManager.rates?.dictRates.count, 33, "dictRates quantity unexpected")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
