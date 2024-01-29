//
//  SelectProfileViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/21/24.
//

import UIKit
import SnapKit

class SelectProfileViewController: UIViewController {
    
    let currentProfileImageView = RoundImageView(frame: .zero)
    lazy var profileCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let udManager = UserDefaultsManager.shared
    let profileList = UserDefaultsManager.profileList
    var userImage = UserDefaultsManager.shared.userImage {
        didSet {
            profileCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureView()
        configureLayout()
    }
    
}

extension SelectProfileViewController: CodeBaseProtocol {
    
    func configureHierarchy() {
        view.addSubview(currentProfileImageView)
        view.addSubview(profileCollectionView)
    }
    
    func configureView() {
        setBackgroundColor()
        setNavigation(text: "프로필 수정", backButton: true)
        
        setMainProfileImage()
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.isScrollEnabled = false
        profileCollectionView.backgroundColor = .clear
        profileCollectionView.register(SelectProfileCollectionViewCell.self, forCellWithReuseIdentifier: SelectProfileCollectionViewCell.identifier)
    }
    
    func configureLayout() {
        currentProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(180)
            make.centerX.equalTo(view)
        }
        
        profileCollectionView.snp.makeConstraints { make in
            make.top.equalTo(currentProfileImageView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension SelectProfileViewController {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 15
        let cellWidth = UIScreen.main.bounds.width - spacing * 5
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: cellWidth / 4, height: cellWidth / 4)
        
        return layout
    }
    
    func setMainProfileImage() {
        currentProfileImageView.setRoundProfileImage(isBorder: true)
        currentProfileImageView.image = UIImage(named: udManager.userImage)
    }

}

extension SelectProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectProfileCollectionViewCell.identifier, for: indexPath) as! SelectProfileCollectionViewCell

        if userImage == profileList[indexPath.item] {
            
            cell.configureCell(image: profileList[indexPath.item], isBorder: true)

            return cell
        } else {
            
            cell.configureCell(image: profileList[indexPath.item], isBorder: false)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        udManager.userImage = profileList[indexPath.item]
        userImage = udManager.userImage
        setMainProfileImage()
        
    }
    
}
