//
//  TokenDetailsCollectionViewStatisticsCell+Model.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 25.03.23.
//

import Foundation

extension TokenDetailsCollectionViewStatisticsCell {
    struct Model {
        let type: StatisticCellType
        let value: Double?

        enum StatisticCellType {
            case marketCap
            case volume24h
            case percentChange1Mo
            case allTimeHigh

            var typeTitle: String? {
                switch self {
                case .marketCap: return "Market Cap"
                case .volume24h: return "Volume (24h)"
                case .percentChange1Mo: return "Percent Change (1mo)"
                case .allTimeHigh: return "All Time High"
                }
            }
        }

        var valueText: NSAttributedString? {
            guard let value = value else { return nil }
            switch type {
            case .percentChange1Mo:
                return NSAttributedString(percentChange: value)
            case .marketCap, .volume24h:
                return NSAttributedString(string: "$ " + value.abbreviated())
            case .allTimeHigh:
                return NSAttributedString(string: value.formatAsCurrency() ?? "N/A") 
            }
        }
    }
}
