//
//  TokenPriceView+Model.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 29.03.23.
//

import Foundation

extension TokenPriceView {
    enum Model {
        case currentPrice(PriceStackView.Model)
        case hourPriceChange(PriceStackView.Model)
        case dayPriceChange(PriceStackView.Model)
    }
}
