//
//  Double+ConvertToString.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 15.03.23.
//

import Foundation

extension Double {
    func convertToString(withDecimalPoints number: Int) -> String {
        return String(format: "%.\(number)f", self)
    }
}

extension Optional where Wrapped == Double {
    func convertToString(withDecimalPoints number: Int) -> String {
        guard let value = self else { return "" }
        return value.convertToString(withDecimalPoints: number)
    }
}
