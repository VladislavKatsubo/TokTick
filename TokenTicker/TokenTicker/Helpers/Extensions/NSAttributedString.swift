//
//  NSAttributedString.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 15.03.23.
//

import UIKit

extension NSAttributedString {
    convenience init?(percentChange: Double?, prefix: String, color: UIColor) {
        guard let percentChange = percentChange else {
            self.init(string: prefix + "N/A")
            return
        }

        let percentString = percentChange.convertToString(withDecimalPoints: 2) + "%"
        let fullString = prefix + percentString
        let attributedString = NSMutableAttributedString(string: fullString)

        let percentColorAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        attributedString.addAttributes(percentColorAttribute, range: NSRange(location: prefix.count, length: percentString.count))

        self.init(attributedString: attributedString)
    }
}
