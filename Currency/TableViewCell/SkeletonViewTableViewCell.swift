//
//  CurrencyTableViewCell.swift
//  Currency
//
//  Created by William Nabechima on 06/02/19.
//  Copyright © 2019 Teste. All rights reserved.
//

import UIKit

class SkeletonViewCell: CurrencyTableViewCell {
    override func awakeFromNib() {
//        super.awakeFromNib()
        // Initialization code
        self.currencyImageView.layer.cornerRadius = 35
        //        self.contentView.isUserInteractionEnabled = false
    }
    override func expandImage() {
        self.currencyImageView.layer.cornerRadius = 0
        imageTrailingConstraint.constant = self.frame.width
        imageLeadingConstraint.constant = 0
        imageTopConstraint.constant = 0
        imageBottomConstraint.constant = 0
        containerLeadingConstraint.constant = 10

        //        textField.isUserInteractionEnabled = true
        
    }
    
    
    override func shrinkImage() {
        self.currencyImageView.layer.cornerRadius = CurrencyTableViewCell.imageCornerRadiusConstant
        imageTrailingConstraint.constant = CurrencyTableViewCell.containerLeadingConstant - 10
        imageLeadingConstraint.constant = 10
        imageTopConstraint.constant = 10
        imageBottomConstraint.constant = 10
        containerLeadingConstraint.constant = CurrencyTableViewCell.containerLeadingConstant

        
        //        textField.isUserInteractionEnabled = false
        
    }
    
}

