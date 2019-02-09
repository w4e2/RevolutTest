//
//  CurrencyTableViewCell.swift
//  Currency
//
//  Created by William Nabechima on 06/02/19.
//  Copyright © 2019 Teste. All rights reserved.
//

import UIKit
protocol CurrencyTableViewCellDelegate: class {
    func valueChanged(value: Double)
}
class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!

    @IBOutlet weak var containerView: UIView!
    static let imageCornerRadiusConstant: CGFloat = 35
    static let containerLeadingConstant: CGFloat = 90
    weak var delegate: CurrencyTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.currencyImageView.layer.cornerRadius = 35
        self.currencyImageView.layer.borderWidth = 1
        containerView.layer.borderWidth = 1
//        self.contentView.isUserInteractionEnabled = false
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isSelected = false
        self.currencyImageView.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.customizeSelected()
        }else {
            self.customizeDeSelect()
        }
    }
    
    func customizeForRate(presentation: CurrencyPresentationModel, selected: Bool) {
        self.currencyImageView?.image = UIImage(named: presentation.code.rawValue)
        self.currencyCodeLabel.text = "\(presentation.code.rawValue)"
        self.currencyNameLabel.text = presentation.currencyName
        self.textField.text = presentation.value
        if selected {
            self.expandImage()
        }else {
            self.shrinkImage()
        }
    }
    func expandImage() {
        self.currencyImageView.layer.cornerRadius = 0
        imageTrailingConstraint.constant = self.frame.width
        imageLeadingConstraint.constant = 0
        imageTopConstraint.constant = 0
        imageBottomConstraint.constant = 0
        containerLeadingConstraint.constant = 10
        containerView.layer.borderColor = UIColor.black.cgColor
        currencyImageView.layer.borderColor = UIColor.clear.cgColor
//        textField.isUserInteractionEnabled = true
        
    }
    
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        delegate?.valueChanged(value: sender.text?.convertCommaDoubleStringToDouble() ?? 0.0)
    }
    func shrinkImage() {
        self.currencyImageView.layer.cornerRadius = CurrencyTableViewCell.imageCornerRadiusConstant
        imageTrailingConstraint.constant = CurrencyTableViewCell.containerLeadingConstant - 10
        imageLeadingConstraint.constant = 10
        imageTopConstraint.constant = 10
        imageBottomConstraint.constant = 10
        containerLeadingConstraint.constant = CurrencyTableViewCell.containerLeadingConstant
        containerView.layer.borderColor = UIColor.clear.cgColor
        currencyImageView.layer.borderColor = UIColor.black.cgColor

//        textField.isUserInteractionEnabled = false

    }
    func customizeSelected()
    {
        self.textField.isEnabled = true
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.expandImage()
            self.layoutIfNeeded()
        }
        
    }
    func customizeDeSelect() {
        self.textField.isEnabled = false
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.shrinkImage()
            self.layoutIfNeeded()
        }
    }
}

