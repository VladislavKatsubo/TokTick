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
    private let usdPriceLabel = UILabel()
    private let priceChangeLast1HourLabel = UILabel()

    // MARK: - Configure
    func configure(with token: Asset) {
        let usdPrice = token.data.marketData.priceUsd
        self.usdPriceLabel.text = usdPrice?.formatAsCurrency()

        let percentChangeLast1Hour = token.data.marketData.percentChangeUsdLast1Hour
        self.priceChangeLast1HourLabel.attributedText = NSAttributedString(percentChange: percentChangeLast1Hour)
    }

    // MARK: - Public methods
    override func didLoad() {
        setupItems()
    }

    func reset() {
        self.usdPriceLabel.text = nil
        self.priceChangeLast1HourLabel.text = nil
    }
}

private extension TokenMarketDataView {
    // MARK: - Private methods
    func setupItems() {
        setupVerticalStackView()
        setupUsdPriceLabel()
        setuppercentChangeLast1HourLabel()
    }

    // MARK: Vertical StackView
    func setupVerticalStackView() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(usdPriceLabel)
        verticalStackView.addArrangedSubview(priceChangeLast1HourLabel)
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

    func setuppercentChangeLast1HourLabel() {
        priceChangeLast1HourLabel.font = .systemFont(ofSize: Constants.percentChangeFontSize, weight: .semibold)
        priceChangeLast1HourLabel.textColor = Constants.percentChangeBaseColor
    }
}
