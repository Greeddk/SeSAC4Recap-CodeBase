//
//  StringEnum.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import Foundation

enum labelText: String {
    case mainViewLabel = ""
}

enum storyboardName: String {
    case main = "Main"
}

enum tabBarName: String {
    case mainTabBar = "MainTabBarController"
}

enum settingOptionsName: String, CaseIterable {
    case announcement = "공지사항"
    case faq = "자주 묻는 질문"
    case question = "1:1 문의"
    case notification = "알림 설정"
    case restart = "처음부터 시작하기"
}
