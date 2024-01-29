//
//  APIManager.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import Foundation
import Alamofire

struct NaverAPIManager {
    
    static var shoppingList: ShoppingList = ShoppingList(total: 0, start: 0, display: 0, items: [])
    
    func callRequest(text: String, page: Int, sort: String, completionhandler: @escaping (ShoppingList) -> Void) {
        
        // TODO: 상품 이름 <b> 같은거 제거
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let display = 30
        
        let startNum = 1 + 30 * page
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=\(display)&start=\(startNum)&sort=\(sort)"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: ShoppingList.self) { response in
            
            switch response.result {
            case .success(let success):
                
                completionhandler(success)
                
            case .failure(let failure):
                print("통신 오류")
            }
        }
        
        
    }
    
}
