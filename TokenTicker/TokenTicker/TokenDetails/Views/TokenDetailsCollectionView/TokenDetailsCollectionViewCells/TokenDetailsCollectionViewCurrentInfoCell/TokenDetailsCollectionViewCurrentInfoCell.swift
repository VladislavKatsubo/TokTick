//
//  TokenDetailsCollectionViewCurrentInfoCell.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 24.03.23.
//

import UIKit

final class TokenDetailsCollectionViewCurrentInfoCell: TCollectionViewCell {
    private enum Constants {
        static let typeTitleLabelFontColor: UIColor = .gray
        static let typeTitleLabelFontSize: CGFloat = 14.0
        static let typeTitleLabelFont: UIFont = .systemFont(ofSize: Constants.typeTitleLabelFontSize, weight: .regular)
        
        static let valueLabelFontSize: CGFloat = 18.0
        static let valueLabelFont: UIFont = .systemFont(ofSize: Constants.valueLabelFontSize, weight: .semibold)
        
        static let typeTitleLabelTopOffset: CGFloat = 20.0
        static let typeTitleLabelLeadingOffset: CGFloat = 20.0
        static let valueLabelTopOffset: CGFloat = 10.0
        static let valueLabelLeadingOffset: CGFloat = 20.0
    }
    
    private let typeTitleLabel = UILabel()
    private let valueLabel = UILabel()
    
    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }
    
    // MARK: - Configure
    func configure(with model: Model) {
        self.typeTitleLabel.text = model.typeTitle
        self.valueLabel.text = model.valueText
    }
}

private extension TokenDetailsCollectionViewCurrentInfoCell {
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
            make.top.equalToSuperview().offset(Constants.typeTitleLabelTopOffset)
            make.leading.equalToSuperview().offset(Constants.typeTitleLabelLeadingOffset)
        }
    }
    
    func setupValueLabel() {
        addSubview(valueLabel)
        valueLabel.font = Constants.valueLabelFont
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(typeTitleLabel.snp.bottom).offset(Constants.valueLabelTopOffset)
            make.leading.equalToSuperview().offset(Constants.valueLabelLeadingOffset)
        }
    }
}
