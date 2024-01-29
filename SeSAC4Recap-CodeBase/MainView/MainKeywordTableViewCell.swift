//
//  MainKeywordTableViewCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import UIKit

class MainKeywordTableViewCell: UITableViewCell {

    @IBOutlet var searchImageView: UIImageView!
    @IBOutlet var searchedKeyword: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    let udManager = UserDefaultsManager.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
}

extension MainKeywordTableViewCell {
    
    // TODO: 버튼 이미지 크기 변경
    private func setUI() {
        
        backgroundColor = .clear
        
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = .textColor
        
        searchedKeyword.textColor = .textColor
        searchedKeyword.font = .medium
        
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteButton.tintColor = .systemGray
        
    }
    
    func configureCell(text: String) {
        
        searchedKeyword.text = text
    }
    
    
}
