//
//  UITableCell+Extension.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit

protocol TableViewCellProtocol {
    func setBackgroundColor()
}

extension UITableViewCell: TableViewCellProtocol {
    
    func setBackgroundColor() {
        self.backgroundColor = .clear
    }
}
