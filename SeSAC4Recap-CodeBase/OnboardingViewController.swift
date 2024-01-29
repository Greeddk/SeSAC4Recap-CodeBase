//
//  ViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    var appTitleImage = UIImageView()
    var logoImage = UIImageView()
    var startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
}

extension OnboardingViewController: CodeBaseProtocol {
    
    func configureHierarchy() {
        view.addSubview(appTitleImage)
        view.addSubview(logoImage)
        view.addSubview(startButton)
    }
    
    func configureView() {
        setBackgroundColor()
        
        appTitleImage.image = .sesacShopping
        
        logoImage.image = .onboarding
        logoImage.contentMode = .scaleAspectFit
        
        startButton.setUI(text: "시작하기")
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    func configureLayout() {
        appTitleImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.width.equalTo(240)
            make.height.equalTo(140)
            make.centerX.equalTo(view)
        }
        
        logoImage.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(appTitleImage.snp.bottom).offset(60)
            make.height.equalTo(300)
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
    }


}

extension OnboardingViewController {
    
    @objc private func startButtonClicked() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SetProfileViewController.identifier) as! SetProfileViewController

        navigationController?.pushViewController(vc, animated: true)
    }
}

