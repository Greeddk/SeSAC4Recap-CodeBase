//
//  SearchResultCollectionViewCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import UIKit
import Kingfisher
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    let itemImageView = UIImageView()
    let favoriteButton = UIButton()
    let shoppingmallLabel = UILabel()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    
    let udManager = UserDefaultsManager.shared
    var favoriteList = UserDefaultsManager.shared.favoriteList
    
    var productID = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchResultCollectionViewCell: CodeBaseProtocol {
    func configureHierarchy() {
        contentView.addSubviews([itemImageView, favoriteButton, shoppingmallLabel, nameLabel, priceLabel])
    }
    
    func configureView() {
        backgroundColor = .clear
        
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 10
        itemImageView.contentMode = .scaleToFill
        
        shoppingmallLabel.font = .small
        shoppingmallLabel.textColor = .systemGray
        
        nameLabel.numberOfLines = 2
        nameLabel.font = .medium
        nameLabel.textColor = .systemGray4
        
        priceLabel.font = .mediumTitle
        priceLabel.textColor = .systemGray6
        
        favoriteButton.setTitle("", for: .normal)
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .backgroundColor
        favoriteButton.backgroundColor = .textColor
    }
    
    func configureLayout() {
        itemImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(175)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.trailing.equalTo(itemImageView.snp.trailing).offset(-10)
            make.bottom.equalTo(itemImageView.snp.bottom).offset(-10)
        }
        
        shoppingmallLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(2)
            make.leading.equalTo(contentView).offset(10)
            make.height.equalTo(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(shoppingmallLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.greaterThanOrEqualTo(contentView).offset(4)
            make.height.equalTo(22)
        }
    }
    
    func configureCell(item: ShoppingItem) {
        
        let url = URL(string: item.image)
        itemImageView.kf.setImage(with: url)
        
        shoppingmallLabel.text = item.mallName
        
        var itemName = item.title.replacingOccurrences(of: "<b>", with: "")
        itemName = itemName.replacingOccurrences(of: "</b>", with: "")
        nameLabel.text = itemName
        
        priceLabel.text = numberFormatter(text: item.lprice)
        
        productID = item.productId
        
    }
    
    private func numberFormatter(text: String) -> String {
        
        let number = Int(text)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: number)!
        
        return String(describing: result)
        
    }
    
}
