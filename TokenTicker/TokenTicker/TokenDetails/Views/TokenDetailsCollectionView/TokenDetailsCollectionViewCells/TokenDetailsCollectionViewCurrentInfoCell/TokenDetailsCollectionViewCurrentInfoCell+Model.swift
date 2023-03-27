//
//  TokenDetailsCollectionViewCurrentInfoCell+Model.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 25.03.23.
//

import Foundation

extension TokenDetailsCollectionViewCurrentInfoCell {
    struct Model {
        let type: CurrentInfoCellType
        let value: Double?

        enum CurrentInfoCellType {
            case openingPrice
            case highestPrice
            case lowestPrice
            case closePrice
        }

        var typeTitle: String? {
            switch type {
            case .openingPrice: return "Open"
            case .highestPrice: return "High"
            case .lowestPrice: return "Low"
            case .closePrice: return "Close"
            }
        }

        var valueText: String? {
            guard let value = value else { return nil }
            return value.formatAsCurrency()
        }
    }
}
