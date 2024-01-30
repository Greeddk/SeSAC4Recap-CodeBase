//
//  MainTableViewWithImageCell.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit
import SnapKit

class SearchImageTableViewCell: UITableViewCell {

    let mainImageView = UIImageView(frame: .zero)
    let infoLabel = UILabel()
    
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

extension SearchImageTableViewCell: CodeBaseProtocol {
    
    func configureHierarchy() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(infoLabel)
    }
    
    func configureView() {
        setBackgroundColor()
        
        mainImageView.image = .empty
        mainImageView.contentMode = .scaleAspectFit
        
        infoLabel.text = "최근 검색어가 없어요"
        infoLabel.font = .largeTitleBold
        infoLabel.textAlignment = .center
        infoLabel.textColor = .textColor
    }
    
    func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(140)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(30)
        }
    }
    
}
