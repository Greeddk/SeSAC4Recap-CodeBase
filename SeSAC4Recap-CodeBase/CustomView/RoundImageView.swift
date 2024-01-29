//
//  RoundImageView.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/29/24.
//

import UIKit

class RoundImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
    }
    
    override func layoutSubviews() { //??View Drawing Cycle
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
