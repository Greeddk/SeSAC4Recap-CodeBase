//
//  MainTabBarViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/29/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        settingVC.tabBarItem.image = UIImage(systemName: "person")
        
        searchVC.title = "검색"
        settingVC.title = "설정"
        
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.tintColor = .point
        tabBar.backgroundColor = .backgroundColor
        
        setViewControllers([searchVC, settingVC], animated: true)
    }

}
