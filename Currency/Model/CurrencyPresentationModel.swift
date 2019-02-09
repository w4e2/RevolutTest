//
//  CurrencyPresentModel.swift
//  Currency
//
//  Created by pc on 07/02/19.
//  Copyright © 2019 Teste. All rights reserved.
//

import UIKit

struct CurrencyPresentationModel {
    var code: CurrencyCode = .other
    var value: String = ""
    var currencyName: String {
        get{
            return code.currencyName()
        }
    }
}
