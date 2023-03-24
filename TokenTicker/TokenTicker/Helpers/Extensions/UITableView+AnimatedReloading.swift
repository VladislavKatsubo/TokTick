//
//  UITableView+AnimatedReloading.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 17.03.23.
//

import UIKit

extension UITableView {
    func reloadDataWithAnimation(duration: TimeInterval = 0.75) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }) { _ in
            self.reloadData()
            UIView.animate(withDuration: duration) {
                self.alpha = 1.0
            }
        }
    }
}
