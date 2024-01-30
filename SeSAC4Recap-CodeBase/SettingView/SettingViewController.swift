//
//  SettingViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/20/24.
//

import UIKit

class SettingViewController: UIViewController {

    let settingTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let udManager = UserDefaultsManager.shared
    
    var profileImage = UserDefaultsManager.shared.userImage {
        didSet {
            settingTableView.reloadData()
        }
    }
    var nickname = UserDefaultsManager.shared.nickname
    var favoriteCount = UserDefaultsManager.shared.favoriteList.count
    let list = settingOptionsName.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nickname = udManager.nickname
        favoriteCount = udManager.favoriteList.count
        profileImage = udManager.userImage
        
    }

}

extension SettingViewController: CodeBaseProtocol {
    
    func configureHierarchy() {
        view.addSubview(settingTableView)
    }
    
    func configureView() {
        setBackgroundColor()
        setNavigation(text: "설정", backButton: false)
        setTableView()
    }
    
    func configureLayout() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setTableView() {
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.isScrollEnabled = false
        
        settingTableView.backgroundColor = .clear
        settingTableView.separatorColor = .systemGray
        
        let profileXib = UINib(nibName: SettingProfileTableViewCell.identifier, bundle: nil)
        settingTableView.register(profileXib, forCellReuseIdentifier: SettingProfileTableViewCell.identifier)
        
        settingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionTableViewCell")
        
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.identifier, for: indexPath) as! SettingProfileTableViewCell
            
            cell.profileImageView.image = UIImage(named: profileImage)
            cell.configurCell(nickname: nickname, count: favoriteCount)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath)
            
            cell.backgroundColor = .backViewColor
            cell.textLabel?.text = list[indexPath.row].rawValue
            cell.textLabel?.font = .small
            cell.textLabel?.textColor = .systemGray4
            
            if indexPath.row != 4 {
                cell.selectionStyle = .none
            }
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 100
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        if indexPath.section == 0 {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: SetProfileViewController.identifier) as! SetProfileViewController

            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 4 {
            showAlert()
        }
        
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", preferredStyle: .alert)
        
        let confirmButton = UIAlertAction(title: "확인", style: .default) { _ in
            UserDefaults.resetUserDefaults()
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate

            sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
            sceneDelegate?.window?.makeKeyAndVisible()
            
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(confirmButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }

}
