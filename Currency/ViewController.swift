//
//  ViewController.swift
//  Currency
//
//  Created by William Nabechima on 06/02/19.
//  Copyright © 2019 Teste. All rights reserved.
//

import UIKit
import SkeletonView
extension Double {
    func convertToCurrencyString(code: CurrencyCode) -> String {
        
        let localeComponents = [NSLocale.Key.currencyCode.rawValue: code.rawValue]
        let localeIdentifier = NSLocale.localeIdentifier(fromComponents: localeComponents)
        let tempLocale = Locale(identifier: localeIdentifier)
        let formatter = NumberFormatter()
        formatter.locale = tempLocale
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.usesGroupingSeparator = false
        formatter.currencyDecimalSeparator = ","
        
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return formattedTipAmount
        }
        return ""
    }
}
extension String {
    func convertCommaDoubleStringToDouble() -> Double {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","
        let value = formatter.number(from: self ?? "")?.doubleValue
        return value ?? 0.0
    }
}
protocol ViewControllerDelegate : class{
    func numberOfCells() -> Int
//    func currencyChangedPosition()
}
class ViewController: UIViewController {
    @IBOutlet weak var currencyTableView: UITableView!
    let manager = CurrencyManager()
    weak var delegate: ViewControllerDelegate?
//    var result: ApiResult = ApiResult()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.showAnimatedSkeleton()

        manager.responder = self
        self.delegate = manager
        currencyTableView.estimatedRowHeight = 90
        
    }
}
extension ViewController: SkeletonTableViewDataSource,UITableViewDelegate {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SkeletonViewCell"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return delegate?.numberOfCells() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as! CurrencyTableViewCell
        let presentation = manager.getCurrencyPresentitonModel(position: indexPath.row)
        cel.customizeForRate(presentation: presentation, selected: indexPath.row == 0)
        cel.delegate = self
        return cel
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 180 + UIApplication.shared.statusBarFrame.height : 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let currency = tableView as? CurrencyTableView,
            let cel = currency.cellForRow(at: indexPath) as? CurrencyTableViewCell else {
            return
        }
//        currency.reloadSections(IndexSet(integer: 0), with: .automatic)
        manager.updateCurrencyAmount(value: cel.textField.text?.convertCommaDoubleStringToDouble() ?? 0.0, updateUI: false)

        manager.changeBaseRate(position: indexPath.row)
        currency.moveToFirst(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
}
extension ViewController: CurrencyTableViewCellDelegate {
    func valueChanged(value: Double) {
        manager.updateCurrencyAmount(value: value, updateUI: true)
        
    }
}
extension ViewController: CurrencyManagerResponder {
    func selectedCurrencyAmountChanged(currencyAmount: Double) {
        for indexPath in currencyTableView!.indexPathsForVisibleRows! {
            if indexPath.row != 0 {
                let presentation = manager.getCurrencyPresentitonModel(position: indexPath.row)
                let cel = currencyTableView.cellForRow(at: indexPath) as! CurrencyTableViewCell
                cel.textField.text = presentation.value

            }

        }
    }
    func updatedRates(isFirst: Bool) {
        if isFirst {
            
            self.view.hideSkeleton()

            self.currencyTableView.reloadData()
        }else {
            for indexPath in self.currencyTableView.indexPathsForVisibleRows ?? [] {
                if indexPath.row != 0 {
                    let cel = self.currencyTableView.cellForRow(at: indexPath)
                    let presentation = self.manager.getCurrencyPresentitonModel(position: indexPath.row)
                    (cel as! CurrencyTableViewCell).customizeForRate(presentation: presentation,selected: false)
                }
            }
        }
    }
}
