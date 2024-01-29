//
//  SetProfileViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit
import TextFieldEffects

class SetProfileViewController: UIViewController {
    
    var isValidated: Bool = false
    
    let udManager = UserDefaultsManager.shared
    let userState = UserDefaultsManager.shared.userState
    
    @IBOutlet var roundedProfileImage: UIImageView!
    @IBOutlet var camLogoImage: UIImageView!
    @IBOutlet var nicknameTextField: HoshiTextField!
    @IBOutlet var nickInfoLabel: UILabel!
    @IBOutlet var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setNavigation(text: "프로필 설정", backButton: true)
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let image = udManager.userImage
        roundedProfileImage.image = UIImage(named: image)
    }
     
    @objc func tapGestureTapped() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: SelectProfileViewController.identifier) as! SelectProfileViewController
        navigationController?.pushViewController(vc, animated: true)
       
    }

}

extension SetProfileViewController {
    
    private func setDelegate() {
        
        nicknameTextField.delegate = self
    }
    
    private func setProfileImage() {
        
        if !userState {
            
            let image = UserDefaultsManager.profileList[Int.random(in: 0...13)]
            udManager.userImage = image
            
            roundedProfileImage.image = UIImage(named: image)
            
        } else {
            
            let image = udManager.userImage
            roundedProfileImage.image = UIImage(named: image)
            
        }
    }
    private func setUI() {
        
        setBackgroundColor()
        setProfileImage()

        roundedProfileImage.setRoundProfileImage(isBorder: true)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureTapped))
        roundedProfileImage.addGestureRecognizer(tapGesture)
        roundedProfileImage.isUserInteractionEnabled = true
        
        camLogoImage.image = .camera
        
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.placeholderFontScale = 1.3
        nicknameTextField.borderActiveColor = .point
        nicknameTextField.borderInactiveColor = .textColor
        nicknameTextField.placeholderColor = .systemGray
        nicknameTextField.textColor = .textColor
        nicknameTextField.backgroundColor = .backgroundColor
        
        nickInfoLabel.text = " "
        nickInfoLabel.font = .small
        nickInfoLabel.textColor = .point
        
        submitButton.setUI(text: "완료")
        submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        
    }
    
    @objc private func submitButtonClicked() {
        
        if isValidated {
            
            nickInfoLabel.text = "사용할 수 있는 닉네임입니다"
            nickInfoLabel.textColor = .point
            
            udManager.nickname = nicknameTextField.text!
            udManager.userState = true
            
            if userState {
                
                navigationController?.popViewController(animated: true)
            
            } else {
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let vc = storyboard?.instantiateViewController(withIdentifier: tabBarName.mainTabBar.rawValue) as! UITabBarController
//                let nav = UINavigationController(rootViewController: vc)
                
                sceneDelegate?.window?.rootViewController = vc
                sceneDelegate?.window?.makeKeyAndVisible()
                
            }
            
        } else {
            nickInfoLabel.text = "닉네임을 올바르게 입력해주세요"
            nickInfoLabel.textColor = .orange
        }
    }
    
}

// TODO: 로직 고치기
extension SetProfileViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let text = textField.text
        if text!.count < 2 || text!.count >= 10 {
            nickInfoLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            nickInfoLabel.textColor = .red
            isValidated = false
        } else if text!.contains("@") || text!.contains("#") || text!.contains("$") || text!.contains("%") {
            nickInfoLabel.text = "닉네임에 @,#,$,% 는 포함할 수 없어요"
            nickInfoLabel.textColor = .red
            isValidated = false
        } else if text!.contains("0") || text!.contains("1") || text!.contains("2") || text!.contains("3") || text!.contains("4") || text!.contains("5") || text!.contains("6") || text!.contains("7") || text!.contains("8") || text!.contains("9") {
            nickInfoLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            nickInfoLabel.textColor = .red
            isValidated = false
        } else {
            nickInfoLabel.text = nil
            isValidated = true
        }
        
    }

}
