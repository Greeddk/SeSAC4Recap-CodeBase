//
//  SetProfileViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit
import TextFieldEffects
import SnapKit

class SetProfileViewController: UIViewController {
    
    var isValidated: Bool = false
    
    let udManager = UserDefaultsManager.shared
    let userState = UserDefaultsManager.shared.userState
    
    let roundedProfileImage = RoundImageView(frame: .zero)
    let camLogoImage = UIImageView()
    let nicknameTextField = HoshiTextField()
    let nickInfoLabel = UILabel()
    let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let image = udManager.userImage
        roundedProfileImage.image = UIImage(named: image)
    }

}

extension SetProfileViewController: CodeBaseProtocol {
    
    func configureHierarchy() {
        view.addSubview(roundedProfileImage)
        view.addSubview(camLogoImage)
        view.addSubview(nicknameTextField)
        view.addSubview(nickInfoLabel)
        view.addSubview(submitButton)
    }
    
    func configureView() {
        
        setBackgroundColor()
        setNavigation(text: "프로필 설정", backButton: true)
        setProfileImage()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureTapped))
        roundedProfileImage.addGestureRecognizer(tapGesture)
        roundedProfileImage.isUserInteractionEnabled = true
        roundedProfileImage.setRoundProfileImage(isBorder: true)

        
        camLogoImage.image = .camera
        
        nicknameTextField.delegate = self
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.placeholderFontScale = 1.1
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
    
    func configureLayout() {
        roundedProfileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(100)
            make.centerX.equalTo(view)
        }
        
        camLogoImage.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.bottom.equalTo(roundedProfileImage.snp.bottom).offset(1)
            make.trailing.equalTo(roundedProfileImage.snp.trailing).offset(1)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(camLogoImage.snp.bottom).offset(50)
            make.height.equalTo(50)
        }
        
        nickInfoLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(nickInfoLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }

}

extension SetProfileViewController {
    
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
    
    @objc func tapGestureTapped() {
        
        navigationController?.pushViewController(SelectProfileViewController(), animated: true)
       
    }

    @objc private func submitButtonClicked() {
        
        if isValidated {

            udManager.nickname = nicknameTextField.text!
            udManager.userState = true
            
            if userState {
                
                navigationController?.popViewController(animated: true)
            
            } else {
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                sceneDelegate?.window?.rootViewController = MainTabBarViewController()
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
            nickInfoLabel.text = "사용할 수 있는 닉네임입니다"
            nickInfoLabel.textColor = .point
            isValidated = true
        }
        
    }
    
}
