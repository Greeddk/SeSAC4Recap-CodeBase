//
//  ReusableProtocol.swift
//  SeSAC4Recap
//
//  Created by Greed on 1/19/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UIView: ReusableProtocol {
    
    static var identifier: String {
        String(describing: self)
    }
}
