//
//  TokenDetailsCollectionViewAdditionalInfoCell.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 24.03.23.
//

import UIKit

final class TokenDetailsCollectionViewAdditionalInfoCell: TCollectionViewCell {

    private enum Constants {
        static let titleLabelFontColor: UIColor = .gray
        static let titleLabelFontSize: CGFloat = 14.0
        static let titleLabelFont: UIFont = .systemFont(ofSize: Constants.titleLabelFontSize, weight: .regular)

        static let valueLabelFontSize: CGFloat = 20.0
        static let valueLabelFont: UIFont = .systemFont(ofSize: Constants.valueLabelFontSize, weight: .bold)
    }


    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    override func didLoad() {
        setupItems()
    }

    // MARK: - Configure
    func configure(with model: Model) {
        self.titleLabel.text = model.title
        self.valueLabel.text = model.value?.abbreviated()
    }
}

private extension TokenDetailsCollectionViewAdditionalInfoCell {
    // MARK: - Private methods
    func setupItems() {
        setupTypeTitleLabel()
        setupValueLabel()

    }

    func setupTypeTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = Constants.titleLabelFont
        titleLabel.textColor = Constants.titleLabelFontColor
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
        }
    }

    func setupValueLabel() {
        addSubview(valueLabel)
        valueLabel.font = Constants.valueLabelFont
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
        }
    }
}
