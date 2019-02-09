//
//  CurrencyTableView.swift
//  Currency
//
//  Created by William Nabechima on 06/02/19.
//  Copyright © 2019 Teste. All rights reserved.
//

import UIKit

class CurrencyTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func moveToFirst(indexPath: IndexPath) {
        DispatchQueue.main.async {
            let selectedCel = self.cellForRow(at: indexPath) as! CurrencyTableViewCell

            UIView.animate(withDuration: 0.2, animations: {
                self.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
                self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                
            }) { (_) in
//                self.reloadData()
                if !selectedCel.textField.isFirstResponder {
                    selectedCel.textField.becomeFirstResponder()
                }
            }
        }
        
        
    }
}
