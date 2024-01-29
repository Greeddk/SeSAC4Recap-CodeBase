//
//  SettingOptionTableViewCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/20/24.
//

import UIKit

class SettingOptionTableViewCell: UITableViewCell {

    @IBOutlet var optionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .backViewColor

    }
    
}

extension SettingOptionTableViewCell {
    
    func configureCell(text: String) {
        
        optionLabel.text = text
        optionLabel.font = .small
        optionLabel.textColor = .systemGray4
        
    }
}
