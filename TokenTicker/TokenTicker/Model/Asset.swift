//
//  Asset.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 12.03.23.
//

import Foundation

struct Asset: Decodable, Equatable {
    static func == (lhs: Asset, rhs: Asset) -> Bool {
        return lhs.data == rhs.data
    }

    let data: AssetData

    struct AssetData: Decodable, Equatable {
        static func == (lhs: Asset.AssetData, rhs: Asset.AssetData) -> Bool {
            return lhs.name == rhs.name && lhs.symbol == rhs.symbol && lhs.marketData == rhs.marketData
        }

        let name: String
        let symbol: String
        let marketData: MarketData

        struct MarketData: Decodable, Equatable {
            
            let priceUsd: Double?
            let percentChangeUsdLast1Hour: Double?
            let percentChangeUsdLast24Hours: Double?
        }
    }
}
