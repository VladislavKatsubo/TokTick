//
//  TokenSymbolNameView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 15.03.23.
//

import UIKit

final class TokenSymbolNameView: TView {

    private enum Constants {
        static let symbolLabelTextColor: UIColor = .gray
        static let nameFontSize: CGFloat = 18.0
        static let symbolFontSize: CGFloat = 15.0
    }

    private let stackView = TStackView(axis: .vertical, distribution: .fillEqually, spacing: 5.0)
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()

    // MARK: - Configure
    func configure(with coin: Asset) {
        let name = coin.data.name
        let symbol = coin.data.symbol

        self.nameLabel.text = name
        self.symbolLabel.text = symbol
    }

    // MARK: - Public methods
    override func didLoad() {
        setupItems()
    }
}

private extension TokenSymbolNameView {
    // MARK: - Private methods
    func setupItems() {
        setupStackView()
        setupNameLabel()
        setupSymbolLabel()
    }

    func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(symbolLabel)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }

    func setupNameLabel() {
        nameLabel.font = .systemFont(ofSize: Constants.nameFontSize, weight: .semibold)
    }

    func setupSymbolLabel() {
        symbolLabel.font = .systemFont(ofSize: Constants.symbolFontSize)
        symbolLabel.textColor = Constants.symbolLabelTextColor
        symbolLabel.text = symbolLabel.text?.uppercased()
    }
}
