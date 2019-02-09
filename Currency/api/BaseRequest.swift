//
//  BaseRequest.swift
//  Izio
//
//  Created by William Nabechima on 19/04/17.
//  Copyright © 2017 kanamobi. All rights reserved.
//

import UIKit
import Alamofire
class BaseRequest: NSObject {
    class func requestWithMethod(method: String, url: String, parameters: Any?, headers: [String: String]?, withErrorDisclaimer: Bool,responseBlock:@escaping (_ success: Bool?, _ message: String?, _ result: Any?) -> Void) {
        var escapedString: URL = URL(fileURLWithPath: "")
        
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let temp = URL(string: encoded)
        {
            escapedString = temp
            //print(url)
        }
        
        let request = URLRequest(url: escapedString)
        
        switch method {
        case "POST":
            Alamofire.request(request).responseJSON { (response) in
                
                //print(response.response?.statusCode)
                //print(response.response?.statusCode as Any )
                if let status = response.response?.statusCode {
                    
                    if status < 300 && status >= 200{
                        if let result = response.result.value {
                            //print(result)
                            responseBlock(true,nil,result)
                            return
                        }
                        
                    }
                }
                
                if let error = response.error as? URLError {
                    self.actionForSystemError(code: error.code)
                    
                }
                
                responseBlock(false,nil,nil)
                
                
                return
                
                
            }
            //to get JSON return value
            
            
        case "GET":
            
            Alamofire.request(request).responseJSON { (response) in
                
                if let status = response.response?.statusCode {
                    
                    
                    if status < 300 && status >= 200 {
                        if let result = response.result.value {
                            //print(result)
                            responseBlock(true,nil,result)
                            
                            
                            return
                        }
                    }
                }
                if let error = response.error as? URLError {
                    self.actionForSystemError(code: error.code)
                    
                }
                
                responseBlock(false,nil,nil)
                
                
                return
                //to get JSON return value
                
            }
            
        default:
            break
        }
        
        
    }
    class func actionForSystemError(code : URLError.Code) {
        ////print("URLError occurred: \(error.errorCode)")
        switch (code) {
        case .notConnectedToInternet:
            break
            
        ////print("sem conexao")
        case .timedOut:
            
            break
        ////print("timeout")
        case .cancelled:
            break
        ////print("cancel")
        default:
            
            break
        }
        
        return
    }
    
}
