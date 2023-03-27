//
//  FloatingPoint+Currency.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 25.03.23.
//

import Foundation

extension Double {
    func formatAsCurrency(currencySymbol: String = "$",
                                   maximumFractionDigits: Int = 2,
                                   minimumFractionDigits: Int = 0) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = currencySymbol
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        numberFormatter.minimumFractionDigits = minimumFractionDigits

        guard let balanceString = numberFormatter.string(from: NSNumber(value: Double(self))) else { return nil }
        let formattedString = currencySymbol + " " + balanceString.replacingOccurrences(of: numberFormatter.currencySymbol, with: "")

        return formattedString
    }
}
