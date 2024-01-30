//
//  MainViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/18/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let userSearchBar = UISearchBar()
    let headerBackView = UIView()
    let headerLabel = UILabel()
    let allClearButton = UIButton()
    let searchTableView = UITableView()
    
    var udManager = UserDefaultsManager.shared
    
    var searchKeywords = UserDefaultsManager.shared.searchList {
        didSet {
            searchTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nickname = UserDefaultsManager.shared.nickname
        setNavigation(text: "\(nickname)님의 새싹쇼핑", backButton: false)
        userSearchBar.text = ""
        
    }

    @objc private func allClearButtonClicked() {
        
        searchKeywords = []
        udManager.searchList = []
        
    }
    
    @objc private func deleteButtonClicked(sender: UIButton) {
        
        var list = searchKeywords
        list.remove(at: sender.tag)
        udManager.searchList = list
        searchKeywords = udManager.searchList
        
    }
    
}

extension MainViewController: CodeBaseProtocol {
    
    func configureHierarchy() {
        view.addSubviews([userSearchBar, headerBackView, searchTableView])
        headerBackView.addSubviews([headerLabel, allClearButton])
    }
    
    func configureView() {
        
        setBackgroundColor()
        configureTableView()
        
        headerBackView.backgroundColor = .clear
        
        setSearchBar()
        
        headerLabel.text = "최근 검색"
        headerLabel.font = .mediumBold
        
        allClearButton.setTitle("모두 지우기", for: .normal)
        allClearButton.titleLabel?.font = .medium
        allClearButton.addTarget(self, action: #selector(allClearButtonClicked), for: .touchUpInside)
        
        userSearchBar.text = ""
        
        if searchKeywords.isEmpty {
            
            headerLabel.textColor = .textColor
            allClearButton.setTitleColor(.point, for: .normal)

        } else {
            
            headerLabel.textColor = .backgroundColor
            allClearButton.setTitleColor(.backgroundColor, for: .normal)
        }
    }
    
    func configureLayout() {
        userSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        
        headerBackView.snp.makeConstraints { make in
            make.top.equalTo(userSearchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerBackView).offset(8)
            make.trailing.equalTo(headerBackView).offset(70)
            make.top.equalTo(headerBackView).offset(12)
        }
        
        allClearButton.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(20)
            make.trailing.equalTo(headerBackView.snp.trailing).offset(-8)
            make.top.equalTo(headerLabel.snp.top).offset(-2)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(headerBackView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    
    }
    
    private func setSearchBar() {
        
        userSearchBar.barTintColor = .clear
        userSearchBar.searchTextField.leftView?.tintColor = .lightGray
        userSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        userSearchBar.searchTextField.textColor = .textColor
        userSearchBar.backgroundColor = .white

    }
    
    func configureTableView() {
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.backgroundColor = .clear
        
        searchTableView.register(MainImageTableViewCell.self, forCellReuseIdentifier: MainImageTableViewCell.identifier)
     
        searchTableView.register(MainKeywordTableViewCell.self, forCellReuseIdentifier: MainKeywordTableViewCell.identifier)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchKeywords.count != 0 ? searchKeywords.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchKeywords.isEmpty {
            
            tableView.allowsSelection = false
            tableView.isScrollEnabled = false
            
            headerLabel.textColor = .backgroundColor
            
            allClearButton.setTitleColor(.backgroundColor, for: .normal)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MainImageTableViewCell.identifier) as! MainImageTableViewCell
            
            return cell
            
        } else {
            
            tableView.allowsSelection = true
            tableView.isScrollEnabled = true
            
            headerLabel.textColor = .textColor
            
            allClearButton.setTitleColor(.point, for: .normal)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MainKeywordTableViewCell.identifier, for: indexPath) as! MainKeywordTableViewCell
            
            var list = searchKeywords
            list.reverse()
            
            cell.configureCell(text: list[indexPath.row])
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if searchKeywords.isEmpty {
            return UIScreen.main.bounds.height / 2
        }
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        var list = searchKeywords
        list.reverse()
        
        let text = list[indexPath.row]
  
        udManager.searchKeyword = text
        
        let vc = SearchResultViewController()
        vc.configureNavigationBar(text: text)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MainViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, !text.isEmpty else { return }

        searchKeywords.append(text)
        udManager.searchList = searchKeywords
        udManager.searchKeyword = text
        
        SearchResultViewController().configureNavigationBar(text: text)
        
        let sb = UIStoryboard(name: "main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
