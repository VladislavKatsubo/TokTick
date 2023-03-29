//
//  TokenDetailsViewModel.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 23.03.23.
//

import Foundation

protocol TokenDetailsViewModelProtocol {
    var onStateChange: ((TokenDetailsResources.State) -> Void)? { get set }
    func launch()
}

final class TokenDetailsViewModel: TokenDetailsViewModelProtocol {

    typealias Constants = TokenDetailsResources.Constants.Mocks

    private var token: Asset?

    var onStateChange: ((TokenDetailsResources.State) -> Void)?

    // MARK: - Init
    init(token: Asset) {
        self.token = token
    }

    // MARK: - Public methods
    func launch() {
        setupModels()
    }
}

private extension TokenDetailsViewModel {
    // MARK: - Private methods
    func setupModels() {
        setupTokenPriceView()
        setupSections()
        setupTitle()
    }

    func setupTokenPriceView() {
        let models: [TokenPriceView.Model] = [
            .currentPrice(
                .init(
                    title: Constants.currentPriceTitle,
                    value: token?.data.marketData.priceUsd
                )
            ),
            .dayPriceChange(
                .init(
                    title: Constants.dayPriceChangeTitle,
                    value: token?.data.marketData.percentChangeUsdLast24Hours
                )
            ),
            .hourPriceChange(
                .init(
                    title: Constants.hourPriceChangeTitle,
                    value: token?.data.marketData.percentChangeUsdLast1Hour
                )
            )
        ]
        onStateChange?(.onPriceView(models))
    }

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
        
        onStateChange?(.onCollectionModels(models))
    }

    func setupTitle() {
        guard let title = token?.data.name else { return }
        onStateChange?(.onSetTitle(title))
    }
}
