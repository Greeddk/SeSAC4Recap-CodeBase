//
//  SearchResultViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    enum ButtonName: String {
        case accurateFilterButton = "정확도"
        case dateFilterButton = "날짜순"
        case highPriceFilterButton = "가격높은순"
        case lowPriceFilterButton = "가격낮은순"
    }
    
    enum SearchSort: String {
        case sim
        case date
        case asc
        case dsc
    }
    
    var sort = SearchSort.sim.rawValue
    
    let numberOfResultLabel = UILabel()
    let accurateFilterButton = UIButton()
    let dateFilterButton = UIButton()
    let highPriceFilterButton = UIButton()
    let lowPriceFilterButton = UIButton()
    lazy var searchResultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let searchManager = NaverAPIManager()
    let udManager = UserDefaultsManager.shared
    var favoriteList = UserDefaultsManager.shared.favoriteList {
        didSet {
            searchResultCollectionView.reloadData()
        }
    }
    var shoppingList = ShoppingList(total: 0, start: 0, display: 0, items: []) {
        didSet {
            searchResultCollectionView.reloadData()
        }
    }
    
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAPI()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteList = UserDefaultsManager.shared.favoriteList
    }
    
    
    @objc func accurateFilterClicked(_ sender: UIButton) {
        
        sort = SearchSort.sim.rawValue
        callAPI()
        
        configureSelectedFilterButton(button: accurateFilterButton, text: "정확도")
        configureNormalFilterButton(button: dateFilterButton, text: "날짜순")
        configureNormalFilterButton(button: highPriceFilterButton, text: "가격높은순")
        configureNormalFilterButton(button: lowPriceFilterButton, text: "가격낮은순")
    }
    
    @objc func dateFilterClicked(_ sender: UIButton) {
        
        sort = SearchSort.date.rawValue
        callAPI()
        
        configureNormalFilterButton(button: accurateFilterButton, text: "정확도")
        configureSelectedFilterButton(button: dateFilterButton, text: "날짜순")
        configureNormalFilterButton(button: highPriceFilterButton, text: "가격높은순")
        configureNormalFilterButton(button: lowPriceFilterButton, text: "가격낮은순")
    }
    
    @objc func highpriceFilterClicked(_ sender: UIButton) {
        
        sort = SearchSort.dsc.rawValue
        callAPI()
        
        configureNormalFilterButton(button: accurateFilterButton, text: "정확도")
        configureNormalFilterButton(button: dateFilterButton, text: "날짜순")
        configureSelectedFilterButton(button: highPriceFilterButton, text: "가격높은순")
        configureNormalFilterButton(button: lowPriceFilterButton, text: "가격낮은순")
    }
    
    @objc func lowpriceFilterClicked(_ sender: UIButton) {
        
        sort = SearchSort.asc.rawValue
        callAPI()
        
        configureNormalFilterButton(button: accurateFilterButton, text: "정확도")
        configureNormalFilterButton(button: dateFilterButton, text: "날짜순")
        configureNormalFilterButton(button: highPriceFilterButton, text: "가격높은순")
        configureSelectedFilterButton(button: lowPriceFilterButton, text: "가격낮은순")
    }
    
    func callAPI() {
        
        let text = udManager.searchKeyword

        page = 0
        searchManager.callRequest(text: text, page: page, sort: sort) { value in
            
            self.shoppingList = value
            
            let totalNum = self.numberFormatter(text: String(self.shoppingList.total))
            self.numberOfResultLabel.text = "\(totalNum) 개의 검색 결과"
        }
        
    }
    
}

extension SearchResultViewController: CodeBaseProtocol {
    
    func configureHierarchy() {
        view.addSubviews([numberOfResultLabel, dateFilterButton, accurateFilterButton, lowPriceFilterButton, highPriceFilterButton, searchResultCollectionView])
    }
    
    func configureView() {
        setBackgroundColor()
        
        numberOfResultLabel.textColor = .point
        numberOfResultLabel.font = .medium
        
        configureSelectedFilterButton(button: accurateFilterButton, text: "정확도")
        configureNormalFilterButton(button: dateFilterButton, text: "날짜순")
        configureNormalFilterButton(button: highPriceFilterButton, text: "가격높은순")
        configureNormalFilterButton(button: lowPriceFilterButton, text: "가격낮은순")
        
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        searchResultCollectionView.prefetchDataSource = self
        
        searchResultCollectionView.backgroundColor = .clear
        
        searchResultCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
    }
    
    func configureLayout() {
        numberOfResultLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(20)
        }
        
        accurateFilterButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.top.equalTo(numberOfResultLabel.snp.bottom).offset(4)
            make.width.equalTo(50)
        }
        
        dateFilterButton.snp.makeConstraints { make in
            make.leading.equalTo(accurateFilterButton.snp.trailing).offset(8)
            make.top.equalTo(numberOfResultLabel.snp.bottom).offset(4)
            make.width.equalTo(50)
        }
        
        highPriceFilterButton.snp.makeConstraints { make in
            make.leading.equalTo(dateFilterButton.snp.trailing).offset(8)
            make.top.equalTo(numberOfResultLabel.snp.bottom).offset(4)
            make.width.equalTo(70)
        }
        
        lowPriceFilterButton.snp.makeConstraints { make in
            make.leading.equalTo(highPriceFilterButton.snp.trailing).offset(8)
            make.top.equalTo(numberOfResultLabel.snp.bottom).offset(4)
            make.width.equalTo(70)
        }
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(accurateFilterButton.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    func configureNavigationBar(text: String) {
        
        setNavigation(text: text, backButton: true)
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - spacing * 3
        let cellHeight = UIScreen.main.bounds.height - spacing * 3
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: cellWidth / 2 , height: cellHeight / 3)
        
        return layout
    }
    
    func configureSelectedFilterButton(button: UIButton, text: String) {
        
        button.setTitle(text, for: .normal)
        button.setTitleColor(.backgroundColor, for: .normal)
        button.titleLabel?.font = .medium
        button.layer.cornerRadius = 8
        button.backgroundColor = .textColor
        button.layer.borderColor = UIColor.textColor.cgColor
        button.layer.borderWidth = 1
    }
    
    func configureNormalFilterButton(button: UIButton, text: String) {
        
        button.setTitle(text, for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = .medium
        button.layer.cornerRadius = 8
        button.backgroundColor = .backgroundColor
        button.layer.borderColor = UIColor.textColor.cgColor
        button.layer.borderWidth = 1
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        let item = shoppingList.items[indexPath.item]
        cell.configureCell(item: item)
        cell.favoriteButton.tag = Int(shoppingList.items[indexPath.item].productId)!
        cell.favoriteButton.addTarget(self, action: #selector(changeFavoriteValue(sender:)), for: .touchUpInside)
        DispatchQueue.main.async { //이게 최선인가..?
            cell.favoriteButton.layer.cornerRadius = cell.favoriteButton.frame.width / 2
        }
        
        if favoriteList.contains(item.productId) {
            cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        return cell
        
    }
    
    @objc func changeFavoriteValue(sender: UIButton) {
        
        if !favoriteList.contains(String(sender.tag)) {
            
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
            var list = udManager.favoriteList
            list.append(String(sender.tag))
            udManager.favoriteList = list
            
        } else {
            
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            
            guard let index = favoriteList.firstIndex(of: String(sender.tag)) else { return }
            var list = favoriteList
            list.remove(at: index)
            udManager.favoriteList = list
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ProductDetailViewController.identifier) as! ProductDetailViewController
        
        vc.item = shoppingList.items[indexPath.item]
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if shoppingList.items.count - 3 == item.item {
                page += 1
                searchManager.callRequest(text: udManager.searchKeyword, page: page, sort: sort) { value in
                    self.shoppingList.items.append(contentsOf: value.items)
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
}
