//
//  TokenMarketDataView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 15.03.23.
//

import UIKit

final class TokenMarketDataView: TView {

    private enum Constants {
        static let usdPriceFontSize: CGFloat = 18.0
        static let usdPriceFontColor: UIColor = .black

        static let percentChangeFontSize: CGFloat = 14.0
        static let percentChangeBaseColor: UIColor = .gray
        
        static let spacing: CGFloat = 5.0
    }

    private let verticalStackView = TStackView(axis: .vertical, distribution: .fillEqually, spacing: Constants.spacing)
    private let horizontalStackView = TStackView(axis: .horizontal, distribution: .fillEqually, spacing: Constants.spacing)
    private let usdPriceLabel = UILabel()
    private let percentChangeLast1HourLabel = UILabel()
    private let percentChangeLast24HourLabel = UILabel()

    // MARK: - Configure
    func configure(with coin: Asset) {
        let usdPrice = coin.data.marketData.priceUsd
        let percentChangeLast1Hour = coin.data.marketData.percentChangeUsdLast1Hour
        let percentChangeLast24Hour = coin.data.marketData.percentChangeUsdLast24Hours

        self.usdPriceLabel.text = usdPrice?.formatAsCurrency()

        let percentChangeLast1HourText = NSAttributedString(percentChange: percentChangeLast1Hour, prefix: "h: ")
        let percentChangeLast24HourText = NSAttributedString(percentChange: percentChangeLast24Hour, prefix: "d: ")

        self.percentChangeLast1HourLabel.attributedText = percentChangeLast1HourText
        self.percentChangeLast24HourLabel.attributedText = percentChangeLast24HourText
    }

    // MARK: - Public methods
    override func didLoad() {
        setupItems()
    }
}

private extension TokenMarketDataView {
    // MARK: - Private methods
    func setupItems() {
        setupVerticalStackView()
        setupUsdPriceLabel()
        setupHorizontalStackView()
        setuppercentChangeLast1HourLabel()
        setuppercentChangeLast24HourLabel()
    }

    // MARK: Vertical StackView
    func setupVerticalStackView() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(usdPriceLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.alignment = .trailing
        verticalStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }

    func setupUsdPriceLabel() {
        usdPriceLabel.font = .systemFont(ofSize: Constants.usdPriceFontSize, weight: .semibold)
        usdPriceLabel.textColor = Constants.usdPriceFontColor
        usdPriceLabel.textAlignment = .right
    }

    // MARK: Horizontal StackView
    func setupHorizontalStackView() {
        horizontalStackView.addArrangedSubview(percentChangeLast1HourLabel)
        horizontalStackView.addArrangedSubview(percentChangeLast24HourLabel)
    }

    func setuppercentChangeLast1HourLabel() {
        percentChangeLast1HourLabel.font = .systemFont(ofSize: Constants.percentChangeFontSize, weight: .semibold)
        percentChangeLast1HourLabel.textColor = Constants.percentChangeBaseColor
        percentChangeLast1HourLabel.textAlignment = .right
        percentChangeLast1HourLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    func setuppercentChangeLast24HourLabel() {
        percentChangeLast24HourLabel.font = .systemFont(ofSize: Constants.percentChangeFontSize, weight: .semibold)
        percentChangeLast24HourLabel.textColor = Constants.percentChangeBaseColor
        percentChangeLast24HourLabel.textAlignment = .right
        percentChangeLast24HourLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
