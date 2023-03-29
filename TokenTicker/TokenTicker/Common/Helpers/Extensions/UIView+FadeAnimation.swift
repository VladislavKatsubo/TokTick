//
//  UIView+FadeAnimation.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 29.03.23.
//

import UIKit

extension UIView {
    func fadeAnimation(withDuration duration: TimeInterval = 0.75, viewsToHide: [UIView], viewsToShow: [UIView]? = nil, completion: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            viewsToHide.forEach { $0.alpha = 0.0 }
        }) { _ in
            completion()
            UIView.animate(withDuration: duration) {
                viewsToShow?.forEach { $0.alpha = 1.0 }
            }
        }
    }
}
