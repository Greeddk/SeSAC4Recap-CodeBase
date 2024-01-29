//
//  ProductDetailViewController.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/20/24.
//

import UIKit
import WebKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet var productDetailWebView: WKWebView!
    
    var item: Item = Item(title: "", link: "", image: "", lprice: "", productId: "", mallName: "")
    
    let udManager = UserDefaultsManager.shared
    let favoriteList = UserDefaultsManager.shared.favoriteList
    
    lazy var isFavorite: Bool = UserDefaultsManager.shared.favoriteList.contains(item.productId) {
        didSet {
            setFavoriteButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

}

extension ProductDetailViewController {
    
    private func setUI() {
        
        setBackgroundColor()
        
        tabBarController?.tabBar.barTintColor = .backgroundColor
        
        var itemName = item.title.replacingOccurrences(of: "<b>", with: "")
        itemName = itemName.replacingOccurrences(of: "</b>", with: "")
        
        setNavigation(text: itemName, backButton: true)
        
        setFavoriteButton()
        
        guard let url = URL(string: "https://msearch.shopping.naver.com/product/\(item.productId)") else { return }
        productDetailWebView.load(URLRequest(url: url))
        
    }
    
    private func setFavoriteButton() {
        
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: isFavorite ? "heart.fill" : "heart"), style: .plain, target: self, action: #selector(favoriteButtonClicked))
        favoriteButton.tintColor = .textColor
        navigationItem.rightBarButtonItem = favoriteButton
        
    }
    
    @objc private func favoriteButtonClicked() {
        
        isFavorite.toggle()
        
        if isFavorite {

            var list = udManager.favoriteList
            list.append(item.productId)
            udManager.favoriteList = list
            
        } else {
            
            guard let index = favoriteList.firstIndex(of: item.productId) else { return }
            var list = favoriteList
            list.remove(at: index)
            udManager.favoriteList = list
              
        }
    }
    
}
