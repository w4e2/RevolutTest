//
//  GitWS.swift
//  TesteCedroIOS
//
//  CreateCurrencyWSd by pc on 31/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit
class CurrencyWS: NSObject {
    class func getRatesForCurrency(currencyCode: CurrencyCode, responseBlock:@escaping (_ success: Bool, _ message: String?,_ result: ApiResult?) -> Void) {
        guard currencyCode != .other else {
            return
        }
        let url = "\(ApiUrl.rootURL)\(currencyCode.rawValue)"
//        print(url)
        BaseRequest.requestWithMethod(method: "GET", url: url, parameters: nil, headers: nil, withErrorDisclaimer: true) { (success, message, result) in
            if success == true {
                guard let dict = result as? [String:Any] else {
                    responseBlock(false,nil,nil)
                    return
                }
                let temp = ApiResult(object: dict)
                responseBlock(true,nil,temp)
            } else {
                responseBlock(false,nil,nil)
                
            }
        }
    }
}
