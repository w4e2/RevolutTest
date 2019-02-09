//
//  ApiResult.swift
//  Currency
//
//  Created by pc on 06/02/19.
//  Copyright © 2019 Teste. All rights reserved.
//

import UIKit
struct ApiResult {
    var codes: [CurrencyCode] = [] {
        didSet{
            
        }
    }
    var dictRates: [CurrencyCode: Double] = [:]
    init() {
    }
    init(object: [String: Any]) {
        let baseCode = CurrencyCode(rawValue: object["base"] as! String) ?? .other
        codes.append(baseCode)
        dictRates.updateValue(1.0, forKey: baseCode)
        if let dict = object["rates"] as? [String: Double] {
            for (key,value) in dict {
                let code = CurrencyCode(rawValue: key) ?? .other
                codes.append(code)
                self.dictRates.updateValue(value, forKey: code)
            }
        }
//        print(codes)
    }
    func updateResult(updatedResult: ApiResult?) -> ApiResult {
        guard updatedResult != nil && codes.count > 0 else {
            return updatedResult!
        }
        var response = ApiResult()
        response.codes = self.codes
        response.dictRates = updatedResult!.dictRates
        return response
    
    }
}
