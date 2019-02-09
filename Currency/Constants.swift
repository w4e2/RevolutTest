//
//  Constants.swift
//  TesteIOSWilliam
//
//  Created by pc on 12/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit
struct ApiUrl {
    static let rootURL = "https://revolut.duckdns.org/latest?base="
}
enum CurrencyCode: String {
    case AUD,BGN,BRL,CAD,CHF,CNY,CZK,DKK,EUR,GBP,HKD,HRK,HUF,IDR,ILS,INR,ISK,JPY,KRW,MXN,MYR,NOK,NZD,PHP,PLN,RON,RUB,SEK,SGD,THB,TRY,USD,ZAR,other
    
    func currencyName() -> String {
//        let localeComponents = [NSLocale.Key.currencyCode.rawValue: "EUR"]
//        let localeIdentifier = NSLocale.localeIdentifier(fromComponents: localeComponents)
        let tempLocale = Locale.current
        print(self.rawValue)
        print(tempLocale)
        print(tempLocale.localizedString(forCurrencyCode: self.rawValue) ?? "")

//        dump(tempLocale)
        return tempLocale.localizedString(forCurrencyCode: self.rawValue) ?? ""
    }
}
