//
//  SearchResultCollectionViewCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import UIKit
import Kingfisher

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var shoppingmallLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    let udManager = UserDefaultsManager.shared
    var favoriteList = UserDefaultsManager.shared.favoriteList
    
    var productID = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
}

extension SearchResultCollectionViewCell {
    
    private func setUI() {
        
        backgroundColor = .clear
        
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
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
    }
    
    func configureCell(item: Item) {
        
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
