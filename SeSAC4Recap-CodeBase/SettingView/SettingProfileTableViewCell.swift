//
//  SettingProfileTableViewCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/20/24.
//

import UIKit

class SettingProfileTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var userFavoriteInfoLabel: UILabel!
    
    let udManager = UserDefaultsManager.shared
    var favoriteCount: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setUI()
        
    }

}

extension SettingProfileTableViewCell {
    
    private func setUI() {
        
        backgroundColor = .backViewColor
        
        profileImageView.setRoundProfileImage(isBorder: true)
        profileImageView.image = UIImage(named: udManager.userImage)
        
        nicknameLabel.font = .largeTitleBold
        nicknameLabel.textColor = .textColor
        
        userFavoriteInfoLabel.font = .largeBold
        userFavoriteInfoLabel.textColor = .textColor
        
    }
    
    func configurCell(nickname: String, count: Int) {
        
        nicknameLabel.text = "\(nickname)"
        
        favoriteCount = count
        let text = "\(favoriteCount)개의 상품을 좋아하고 있어요!"
        userFavoriteInfoLabel.text = text
        changeTextColor(text: text)
        
    }
    
    private func changeTextColor(text: String) {
        
        let attributeString = NSMutableAttributedString(string: text)
        
        attributeString.addAttribute(.foregroundColor, value: UIColor.point, range: (text as NSString).range(of: "\(favoriteCount)개의 상품"))
        
        userFavoriteInfoLabel.attributedText = attributeString
    }
    
}
