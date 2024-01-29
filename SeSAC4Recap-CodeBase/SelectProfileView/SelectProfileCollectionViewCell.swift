//
//  SelectProfileCollectionViewCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/21/24.
//

import UIKit

class SelectProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            self.setUI()
        }
        
    }

}

extension SelectProfileCollectionViewCell {
    
    private func setUI() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    func configureCell(image: String, isBorder: Bool) {
        
        profileImage.image = UIImage(named: image)
        profileImage.setRoundProfileImage(isBorder: isBorder)
        
    }
}
