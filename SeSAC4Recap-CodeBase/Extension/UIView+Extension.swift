//
//  UIView+Extension.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/29/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
