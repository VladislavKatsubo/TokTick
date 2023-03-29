//
//  TokenPriceView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 29.03.23.
//

import UIKit

final class TokenPriceView: TView {
    private enum Constants {
        static let borderWidth: CGFloat = 1.0
        static let borderColor: UIColor = .black
        static let cornerRadius: CGFloat = 25.0
        
        static let insetTopBottom: CGFloat = 20.0
        static let offsetLeading: CGFloat = 20.0
        static let offsetTrailing: CGFloat = 20.0
        static let spacingBetweenViews: CGFloat = 20.0
    }
    
    private let currentPriceView = PriceStackView()
    private let hourPriceChangeView = PriceStackView()
    private let dayPriceChangeView = PriceStackView()
    
    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }
    
    // MARK: - Configure
    func configure(with models: [Model]) {
        models.forEach {
            switch $0 {
            case .currentPrice(let model): currentPriceView.configure(with: model, textAlignment: .left)
            case .hourPriceChange(let model): hourPriceChangeView.configure(with: model, percentage: true)
            case .dayPriceChange(let model): dayPriceChangeView.configure(with: model, percentage: true)
            }
        }
    }
}

private extension TokenPriceView {
    // MARK: - Private methods
    func setupItems() {
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.borderColor.cgColor
        layer.cornerRadius = Constants.cornerRadius
        
        setupCurrentPriceView()
        setupDayPriceChange()
        setupHourPriceChange()
    }
    
    func setupCurrentPriceView() {
        addSubview(currentPriceView)
        currentPriceView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.insetTopBottom)
            make.leading.equalToSuperview().offset(Constants.offsetLeading)
        }
    }
    
    func setupDayPriceChange() {
        addSubview(dayPriceChangeView)
        dayPriceChangeView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.insetTopBottom)
            make.trailing.equalToSuperview().inset(Constants.offsetTrailing)
        }
    }
    
    func setupHourPriceChange() {
        addSubview(hourPriceChangeView)
        hourPriceChangeView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.insetTopBottom)
            make.trailing.equalTo(dayPriceChangeView.snp.leading).offset(-Constants.spacingBetweenViews)
        }
    }
}
