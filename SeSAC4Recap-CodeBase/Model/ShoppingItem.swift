//
//  Item.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import Foundation

struct ShoppingList: Decodable {
    let total: Int
    let start: Int
    let display: Int
    var items: [ShoppingItem]
}

struct ShoppingItem: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let productId: String
    let mallName: String
}
