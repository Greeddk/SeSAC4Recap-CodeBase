//
//  ViewController+Extension.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit

extension UIViewController {
    
    func setBackgroundColor() {
        self.view.backgroundColor = .backgroundColor
    }
    
    func setNavigation(text: String, backButton: Bool) {
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = text
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColor]
        navigationController?.navigationBar.backgroundColor = .backgroundColor

        if backButton {
            let image = UIImage(systemName: "chevron.left")
            let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action:  #selector(backButtonClicked))
            backButton.tintColor = .textColor
            
            navigationItem.leftBarButtonItem = backButton
        }
        
    }
    
    func numberFormatter(text: String) -> String {
        
        let number = Int(text)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: number)!
        
        return String(describing: result)
    }
    
    @objc private func backButtonClicked() {
        
        navigationController?.popViewController(animated: true)
    }
    
}
