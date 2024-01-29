//
//  Button+Extension.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit

extension UIButton {
    
    func setUI(text: String) {
        
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 8
        self.tintColor = .white
        self.backgroundColor = .point
        self.setTitle(text, for: .normal)
        
    }
}
