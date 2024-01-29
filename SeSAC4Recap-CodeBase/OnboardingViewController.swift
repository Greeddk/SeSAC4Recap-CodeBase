//
//  ViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet var appTitleImage: UIImageView!
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
}

extension OnboardingViewController {
    
    private func setUI() {
        
        setBackgroundColor()
        
        appTitleImage.image = .sesacShopping
        
        logoImage.image = .onboarding
        
        startButton.setUI(text: "시작하기")
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc private func startButtonClicked() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: SetProfileViewController.identifier) as! SetProfileViewController

        navigationController?.pushViewController(vc, animated: true)
    }
}

