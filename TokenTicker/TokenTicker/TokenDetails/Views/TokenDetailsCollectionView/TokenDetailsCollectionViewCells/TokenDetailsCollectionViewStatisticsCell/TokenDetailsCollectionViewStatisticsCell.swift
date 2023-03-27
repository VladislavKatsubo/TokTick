//
//  TokenDetailsCollectionViewStatisticsCell.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 24.03.23.
//

import UIKit

final class TokenDetailsCollectionViewStatisticsCell: TCollectionViewCell {
    private enum Constants {
        static let typeTitleLabelFontColor: UIColor = .gray
        static let typeTitleLabelFontSize: CGFloat = 14.0
        static let typeTitleLabelFont: UIFont = .systemFont(ofSize: Constants.typeTitleLabelFontSize, weight: .regular)

        static let valueLabelFontSize: CGFloat = 20.0
        static let valueLabelFont: UIFont = .systemFont(ofSize: Constants.valueLabelFontSize, weight: .bold)
    }

    private let typeTitleLabel = UILabel()
    private let valueLabel = UILabel()

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Configure
    func configure(with model: Model) {
        self.typeTitleLabel.text = model.type.typeTitle
        self.valueLabel.attributedText = model.valueText
    }
}

private extension TokenDetailsCollectionViewStatisticsCell {
    // MARK: - Private methods
    func setupItems() {
        setupTypeTitleLabel()
        setupValueLabel()
    }

    func setupTypeTitleLabel() {
        addSubview(typeTitleLabel)
        typeTitleLabel.font = Constants.typeTitleLabelFont
        typeTitleLabel.textColor = Constants.typeTitleLabelFontColor
        typeTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
        }
    }

    func setupValueLabel() {
        addSubview(valueLabel)
        valueLabel.font = Constants.valueLabelFont
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(typeTitleLabel.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
        }
    }
}

