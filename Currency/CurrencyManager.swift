//
//  CurrencyManager.swift
//  Currency
//
//  Created by pc on 07/02/19.
//  Copyright © 2019 Teste. All rights reserved.
//

import UIKit
protocol CurrencyManagerResponder: class {
    func updatedRates(isFirst: Bool)
    func selectedCurrencyAmountChanged(currencyAmount: Double)
    
}
class CurrencyManager: NSObject {
    let semaphore = DispatchSemaphore(value: 1)

    weak var responder: CurrencyManagerResponder? {
        didSet {
            self.getRates()
        }
    }
    var rates: ApiResult? = ApiResult()
    var lastCurrencyCode: CurrencyCode = .EUR
    var currencyAmount: Double = 100.0 
    func getRates() {
        CurrencyWS.getRatesForCurrency(currencyCode: .EUR) { (success, message, result) in
            if success {
                print(result!)
                let isFirst = self.rates?.codes.count == 0
                print(self.rates!)
                self.updateRates(responce: result!)
                self.responder?.updatedRates(isFirst: isFirst)
                
            }else {
            }
            self.refreshRates()
        }
    }
    func updateCurrencyAmount(value:Double, updateUI: Bool) {
        
        self.currencyAmount = value
        if updateUI {
            self.responder?.selectedCurrencyAmountChanged(currencyAmount: currencyAmount)

        }

    }
    func refreshRates() {
        DispatchQueue.global().async {
            sleep(1)
            self.getRates()
        }
    }
    func changeBaseRate(position: Int) {
        DispatchQueue.global().async {
            guard let item = self.rates?.codes.remove(at: position) else {
                return
            }
            self.rates?.codes.insert(item, at: 0)
        }
        
    }
    func updateRates(responce: ApiResult) {
        self.rates = self.rates?.updateResult(updatedResult: responce)

    }
    func getCurrencyPresentitonModel(position: Int) -> CurrencyPresentationModel {
        if let code = self.rates?.codes[position],
            let value = self.rates?.dictRates[code],
            let selectedItem = self.rates?.codes.first,
            let selectedValue = self.rates?.dictRates[selectedItem]{
            var presentation = CurrencyPresentationModel()
            presentation.code = code
            presentation.value = (value*currencyAmount/selectedValue).convertToCurrencyString(code: code)
            semaphore.signal()

            return presentation
        }

        return CurrencyPresentationModel()
    }
}
extension CurrencyManager: ViewControllerDelegate {
    func numberOfCells() -> Int {
        return self.rates?.codes.count ?? 0
    }
}
