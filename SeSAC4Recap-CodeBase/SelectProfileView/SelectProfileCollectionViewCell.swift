//
//  SelectProfileCollectionViewCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/21/24.
//

import UIKit
import SnapKit

class SelectProfileCollectionViewCell: UICollectionViewCell {
    
    let profileImage = RoundImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SelectProfileCollectionViewCell: CodeBaseProtocol {
    
    func configureHierarchy() {
        contentView.addSubview(profileImage)
    }
    
    func configureView() {
        
    }
    
    func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configureCell(image: String, isBorder: Bool) {
        
        profileImage.image = UIImage(named: image)
        profileImage.setRoundProfileImage(isBorder: isBorder)
        
    }
}
