//
//  PriceStackView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 29.03.23.
//

import UIKit

final class PriceStackView: TView {
    private enum Constants {
        static let titleLabelFontColor: UIColor = .gray
        static let titleLabelFontSize: CGFloat = 14.0
        static let titleLabelFont: UIFont = .systemFont(ofSize: Constants.titleLabelFontSize, weight: .regular)

        static let valueLabelFontSize: CGFloat = 16.0
        static let valueLabelFont: UIFont = .systemFont(ofSize: Constants.valueLabelFontSize, weight: .semibold)
    }

    private let stackView = TStackView(axis: .vertical, spacing: 5.0)
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Public methods
    func configure(with model: Model, textAlignment: NSTextAlignment = .right, percentage: Bool = false) {
        titleLabel.text = model.title
        titleLabel.textAlignment = textAlignment
        valueLabel.attributedText = percentage ? NSAttributedString(percentChange: model.value) : NSAttributedString(string: model.value?.formatAsCurrency() ?? "N/A")
        valueLabel.textAlignment = textAlignment
    }
}

private extension PriceStackView {
    // MARK: - Private methods
    func setupItems() {
        setupStackView()
        setupTitleLabel()
        setupValueLabel()
    }

    func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupTitleLabel() {
        titleLabel.font = Constants.titleLabelFont
        titleLabel.textColor = Constants.titleLabelFontColor

    }

    func setupValueLabel() {
        valueLabel.font = Constants.valueLabelFont
    }
}
