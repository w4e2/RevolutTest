//
//  Rate.swift
//  Currency
//
//  Created by pc on 06/02/19.
//  Copyright © 2019 Teste. All rights reserved.
//

import UIKit
struct Rate{
    var code: CurrencyCode!
//    var value: Double?
    init?(code: CurrencyCode) {
        self.code = code
    }
    
}
    extension Rate: Equatable {
        static func ==(lhs: Rate, rhs: Rate) -> Bool {

        let areEqual = lhs.code == rhs.code
        return areEqual
    }
}
