//
//  SelectProfileViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/21/24.
//

import UIKit

class SelectProfileViewController: UIViewController {
    
    @IBOutlet var currentProfileImageView: UIImageView!
    @IBOutlet var profileCollectionView: UICollectionView!
    
    let udManager = UserDefaultsManager.shared
    let profileList = UserDefaultsManager.profileList
    var userImage = UserDefaultsManager.shared.userImage {
        didSet {
            profileCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setCollectionView()
        
    }
    
}

extension SelectProfileViewController {
    
    private func setUI() {
        
        setBackgroundColor()
        setNavigation(text: "프로필 수정", backButton: true)
        
        setMainProfileImage()
        
    }
    
    private func setMainProfileImage() {
        
        currentProfileImageView.setRoundProfileImage(isBorder: true)
        currentProfileImageView.image = UIImage(named: udManager.userImage)
        
    }
    
    private func setCollectionView() {
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.isScrollEnabled = false
        profileCollectionView.backgroundColor = .clear
        
        let xib = UINib(nibName: SelectProfileCollectionViewCell.identifier, bundle: nil)
        profileCollectionView.register(xib, forCellWithReuseIdentifier: SelectProfileCollectionViewCell.identifier)
        
        let spacing: CGFloat = 15
        let cellWidth = UIScreen.main.bounds.width - spacing * 5
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: cellWidth / 4, height: cellWidth / 4)
        
        profileCollectionView.collectionViewLayout = layout
        
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
