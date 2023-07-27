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
        let allTimeHigh: AllTimeHigh
        let marketcap: Marketcap
        let roiData: RoiData
        let supply: Supply

        struct MarketData: Decodable, Equatable {
            
            let priceUsd: Double?
            let percentChangeUsdLast1Hour: Double?
            let percentChangeUsdLast24Hours: Double?
            let volumeLast24Hours: Double?
            let ohlcvLast1Hour: OHLCVLastHour

            struct OHLCVLastHour: Decodable, Equatable {
                let open: Double?
                let high: Double?
                let low: Double?
                let close: Double?
                let volume: Double?
            }
        }

        struct AllTimeHigh: Decodable, Equatable {
            let price: Double?
        }

        struct Marketcap: Decodable, Equatable {
            let currentMarketcapUsd: Double?
        }

        struct RoiData: Decodable, Equatable {
            let percentChangeLast1Month: Double?
        }

        struct Supply: Decodable, Equatable {
            let circulating: Double?
        }
    }
}

class AssetWrapper: NSObject {
    let assets: [Asset]
    
    init(assets: [Asset]) {
        self.assets = assets
    }
}
