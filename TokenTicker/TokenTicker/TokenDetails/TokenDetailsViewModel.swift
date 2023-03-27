//
//  TokenDetailsViewModel.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 23.03.23.
//

import Foundation

protocol TokenDetailsViewModelProtocol {
    func launch()
    var onCollectionModels: (([TokenDetailsCollectionView.CellModel]) -> Void)? { get set }
    var onSetTitle: ((String) -> Void)? { get set }
}

final class TokenDetailsViewModel: TokenDetailsViewModelProtocol {

    typealias Constants = TokenDetailsResources.Constants.Mocks

    private var token: Asset?

    var onCollectionModels: (([TokenDetailsCollectionView.CellModel]) -> Void)?
    var onSetTitle: ((String) -> Void)?

    init(token: Asset) {
        self.token = token
    }

    // MARK: - Public methods
    func launch() {
        setupSections()
        setupTitle()
    }
}

private extension TokenDetailsViewModel {
    // MARK: - Private methods
    func setupSections() {
        let models: [TokenDetailsCollectionView.CellModel] = [
            .currentInfoSectionModel([
                TokenDetailsCollectionViewCurrentInfoCell.Model(
                    type: .openingPrice,
                    value: token?.data.marketData.ohlcvLast1Hour.open
                ),
                TokenDetailsCollectionViewCurrentInfoCell.Model(
                    type: .closePrice,
                    value: token?.data.marketData.ohlcvLast1Hour.close
                ),
                TokenDetailsCollectionViewCurrentInfoCell.Model(
                    type: .highestPrice,
                    value: token?.data.marketData.ohlcvLast1Hour.high
                ),
                TokenDetailsCollectionViewCurrentInfoCell.Model(
                    type: .lowestPrice,
                    value: token?.data.marketData.ohlcvLast1Hour.low
                ),
            ]),
            .additionalCurrentInfoSectionModel(
                TokenDetailsCollectionViewAdditionalInfoCell.Model(
                    title: Constants.additionalCurrentInfoLabelText,
                    value: token?.data.marketData.ohlcvLast1Hour.volume
                )
            ),
            .statisticsSectionModels([
                TokenDetailsCollectionViewStatisticsCell.Model(
                    type: .marketCap,
                    value: token?.data.marketcap.currentMarketcapUsd
                ),
                TokenDetailsCollectionViewStatisticsCell.Model(
                    type: .volume24h,
                    value: token?.data.marketData.volumeLast24Hours
                ),
                TokenDetailsCollectionViewStatisticsCell.Model(
                    type: .allTimeHigh,
                    value: token?.data.allTimeHigh.price
                ),
                TokenDetailsCollectionViewStatisticsCell.Model(
                    type: .percentChange1Mo,
                    value: token?.data.roiData.percentChangeLast1Month
                ),
            ]),
            .additionalInfoSectionModel(
                TokenDetailsCollectionViewAdditionalInfoCell.Model(
                    title: Constants.additionalStatisticsInfoLabelText,
                    value: token?.data.supply.circulating
                )
            )
        ]
        
        onCollectionModels?(models)
    }

    func setupTitle() {
        guard let title = token?.data.name else { return }
        onSetTitle?(title)
    }
}
