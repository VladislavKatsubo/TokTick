//
//  TokenListResources.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import Foundation

struct TokenListResources {
    // MARK: - States
    enum State {
        case onFetchTokens([Asset])
        case onSort([IndexPath: IndexPath])
        case onMockTokenListView
        case onAssetTableLabel(String)
        case onAccountView(TokenListAccountView.Model)
        case onBalanceView(Double)
    }

    enum Constants {

        enum UI {
            static let stackViewCustomSpacingAfterAccountView: CGFloat = 30.0
            static let stackViewCustomSpacingAfterBalanceView: CGFloat = 30.0
            static let stackViewCustomSpacingAfterTableViewToolBar: CGFloat = 10.0
            static let stackViewTopOffset: CGFloat = 20.0
            static let stackViewLeadingTrailingInset: CGFloat = 20.0

            static let alertControllerTitle: String = "Sort by"
            static let alertActionHourAscendingTitle: String = "Hour: Ascending"
            static let alertActionHourDescendingTitle: String = "Hour: Descending"
            static let alertActionAlphabeticalAscendingTitle: String = "Alphabetical: A-Z"
            static let alertActionAlphabeticalDescendingTitle: String = "Alphabetical: Z-A"
            static let alertControllerCancelActionTitle: String = "Cancel"
        }

        enum Mocks {
            static let assets: [Asset] = [
                Asset(data: Asset.AssetData(
                    name: "Bitcoin",
                    symbol: "BTC",
                    marketData: Asset.AssetData.MarketData(
                        priceUsd: 25000.921529520783,
                        percentChangeUsdLast1Hour: 1.2990327694951016,
                        percentChangeUsdLast24Hours: 23.57694951,
                        volumeLast24Hours: 6250189978.953322,
                        ohlcvLast1Hour: Asset.AssetData.MarketData.OHLCVLastHour(
                            open: 27822.300243175727,
                            high: 27823.365308425626,
                            low: 27811.173236838862,
                            close: 27811.714654838353,
                            volume: 836147.5431215521
                        )
                    ),
                    allTimeHigh: Asset.AssetData.AllTimeHigh(price: 68753.85761733251),
                    marketcap: Asset.AssetData.Marketcap(currentMarketcapUsd: 533020111906.11993),
                    roiData: Asset.AssetData.RoiData(percentChangeLast1Month: 15.248634893274126),
                    supply: Asset.AssetData.Supply(circulating: 19326293)
                )),
                Asset(data: Asset.AssetData(
                    name: "Bitcoin",
                    symbol: "BTC",
                    marketData: Asset.AssetData.MarketData(
                        priceUsd: 25000.921529520783,
                        percentChangeUsdLast1Hour: 1.2990327694951016,
                        percentChangeUsdLast24Hours: 23.57694951,
                        volumeLast24Hours: 6250189978.953322,
                        ohlcvLast1Hour: Asset.AssetData.MarketData.OHLCVLastHour(
                            open: 27822.300243175727,
                            high: 27823.365308425626,
                            low: 27811.173236838862,
                            close: 27811.714654838353,
                            volume: 836147.5431215521
                        )
                    ),
                    allTimeHigh: Asset.AssetData.AllTimeHigh(price: 68753.85761733251),
                    marketcap: Asset.AssetData.Marketcap(currentMarketcapUsd: 533020111906.11993),
                    roiData: Asset.AssetData.RoiData(percentChangeLast1Month: 15.248634893274126),
                    supply: Asset.AssetData.Supply(circulating: 19326293)
                )),
                Asset(data: Asset.AssetData(
                    name: "Bitcoin",
                    symbol: "BTC",
                    marketData: Asset.AssetData.MarketData(
                        priceUsd: 25000.921529520783,
                        percentChangeUsdLast1Hour: 1.2990327694951016,
                        percentChangeUsdLast24Hours: 23.57694951,
                        volumeLast24Hours: 6250189978.953322,
                        ohlcvLast1Hour: Asset.AssetData.MarketData.OHLCVLastHour(
                            open: 27822.300243175727,
                            high: 27823.365308425626,
                            low: 27811.173236838862,
                            close: 27811.714654838353,
                            volume: 836147.5431215521
                        )
                    ),
                    allTimeHigh: Asset.AssetData.AllTimeHigh(price: 68753.85761733251),
                    marketcap: Asset.AssetData.Marketcap(currentMarketcapUsd: 533020111906.11993),
                    roiData: Asset.AssetData.RoiData(percentChangeLast1Month: 15.248634893274126),
                    supply: Asset.AssetData.Supply(circulating: 19326293)
                )),
                Asset(data: Asset.AssetData(
                    name: "Bitcoin",
                    symbol: "BTC",
                    marketData: Asset.AssetData.MarketData(
                        priceUsd: 25000.921529520783,
                        percentChangeUsdLast1Hour: 1.2990327694951016,
                        percentChangeUsdLast24Hours: 23.57694951,
                        volumeLast24Hours: 6250189978.953322,
                        ohlcvLast1Hour: Asset.AssetData.MarketData.OHLCVLastHour(
                            open: 27822.300243175727,
                            high: 27823.365308425626,
                            low: 27811.173236838862,
                            close: 27811.714654838353,
                            volume: 836147.5431215521
                        )
                    ),
                    allTimeHigh: Asset.AssetData.AllTimeHigh(price: 68753.85761733251),
                    marketcap: Asset.AssetData.Marketcap(currentMarketcapUsd: 533020111906.11993),
                    roiData: Asset.AssetData.RoiData(percentChangeLast1Month: 15.248634893274126),
                    supply: Asset.AssetData.Supply(circulating: 19326293)
                )),
                Asset(data: Asset.AssetData(
                    name: "Bitcoin",
                    symbol: "BTC",
                    marketData: Asset.AssetData.MarketData(
                        priceUsd: 25000.921529520783,
                        percentChangeUsdLast1Hour: 1.2990327694951016,
                        percentChangeUsdLast24Hours: 23.57694951,
                        volumeLast24Hours: 6250189978.953322,
                        ohlcvLast1Hour: Asset.AssetData.MarketData.OHLCVLastHour(
                            open: 27822.300243175727,
                            high: 27823.365308425626,
                            low: 27811.173236838862,
                            close: 27811.714654838353,
                            volume: 836147.5431215521
                        )
                    ),
                    allTimeHigh: Asset.AssetData.AllTimeHigh(price: 68753.85761733251),
                    marketcap: Asset.AssetData.Marketcap(currentMarketcapUsd: 533020111906.11993),
                    roiData: Asset.AssetData.RoiData(percentChangeLast1Month: 15.248634893274126),
                    supply: Asset.AssetData.Supply(circulating: 19326293)
                )),
                Asset(data: Asset.AssetData(
                    name: "Bitcoin",
                    symbol: "BTC",
                    marketData: Asset.AssetData.MarketData(
                        priceUsd: 25000.921529520783,
                        percentChangeUsdLast1Hour: 1.2990327694951016,
                        percentChangeUsdLast24Hours: 23.57694951,
                        volumeLast24Hours: 6250189978.953322,
                        ohlcvLast1Hour: Asset.AssetData.MarketData.OHLCVLastHour(
                            open: 27822.300243175727,
                            high: 27823.365308425626,
                            low: 27811.173236838862,
                            close: 27811.714654838353,
                            volume: 836147.5431215521
                        )
                    ),
                    allTimeHigh: Asset.AssetData.AllTimeHigh(price: 68753.85761733251),
                    marketcap: Asset.AssetData.Marketcap(currentMarketcapUsd: 533020111906.11993),
                    roiData: Asset.AssetData.RoiData(percentChangeLast1Month: 15.248634893274126),
                    supply: Asset.AssetData.Supply(circulating: 19326293)
                )),
            ]

            static let mockUserModel: TokenListAccountView.Model = .init(
                userName: "Vladislav Katsubo",
                accountType: .personal,
                image: .init(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal),
                balance: 41231.55
            )
        }
    }
}
