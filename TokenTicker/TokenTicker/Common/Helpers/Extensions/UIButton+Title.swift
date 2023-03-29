//
//  UIButton+Title.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 8.03.23.
//

import UIKit

extension UIButton {

    var title: String? {
        get {
            currentTitle
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }

    var titleColor: UIColor? {
        get {
            currentTitleColor
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }
}
