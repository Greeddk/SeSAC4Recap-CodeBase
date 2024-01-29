//
//  Item.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import Foundation

struct ShoppingList: Codable {
    let total: Int
    let start: Int
    let display: Int
    var items: [Item]
}

struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let productId: String
    let mallName: String
}
