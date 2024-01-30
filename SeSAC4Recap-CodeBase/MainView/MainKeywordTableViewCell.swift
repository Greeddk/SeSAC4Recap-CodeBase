//
//  MainKeywordTableViewCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import UIKit

class MainKeywordTableViewCell: UITableViewCell {
    
    let searchImageView = UIImageView(frame: .zero)
    let searchedKeyword = UILabel()
    let deleteButton = UIButton()
    
    let udManager = UserDefaultsManager.shared
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainKeywordTableViewCell: CodeBaseProtocol {
    
    func configureHierarchy() {
        contentView.addSubview(searchImageView)
        contentView.addSubview(searchedKeyword)
        contentView.addSubview(deleteButton)
    }
    
    func configureView() {
        backgroundColor = .clear
        
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = .textColor
        
        searchedKeyword.textColor = .textColor
        searchedKeyword.font = .medium
        
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteButton.tintColor = .systemGray
    }
    
    func configureLayout() {
        searchImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView)
            make.size.equalTo(24)
        }
        
        searchedKeyword.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(20)
            make.centerY.equalTo(contentView)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.greaterThanOrEqualTo(searchedKeyword.snp.trailing).offset(140)
            make.trailing.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
        }
    }
    
    func configureCell(text: String) {
        
        searchedKeyword.text = text
    }
    
}
