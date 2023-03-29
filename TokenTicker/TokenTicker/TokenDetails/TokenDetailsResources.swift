//
//  TokenDetailsResources.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 23.03.23.
//

import Foundation

struct TokenDetailsResources {

    // MARK: - States
    enum State {
        case onPriceView([TokenPriceView.Model])
        case onCollectionModels([TokenDetailsCollectionView.CellModel])
        case onSetTitle(String)
    }

    // MARK: - Constants
    enum Constants {

        enum UI {
            static let tokenPriceViewTopOffset: CGFloat = 20.0
            static let tokenPriceViewLeadingTrailingInset: CGFloat = 20.0
        }

        enum Mocks {
            static let additionalCurrentInfoLabelText: String = "Volume"
            static let additionalStatisticsInfoLabelText: String = "Circulating Supply"

            static let currentPriceTitle: String = "Current price"
            static let hourPriceChangeTitle: String = "1h:"
            static let dayPriceChangeTitle: String = "24h:"
        }
    }
}
