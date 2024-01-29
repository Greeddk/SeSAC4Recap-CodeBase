//
//  MainTableViewWithImageCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit

class MainImageTableViewCell: UITableViewCell {
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
}

extension MainImageTableViewCell {
    
    private func setUI() {
        
        setBackgroundColor()
        
        mainImageView.image = .empty
        
        infoLabel.text = "최근 검색어가 없어요"
        infoLabel.font = .largeTitleBold
        infoLabel.textAlignment = .center
        infoLabel.textColor = .textColor
        
    }
    
}
