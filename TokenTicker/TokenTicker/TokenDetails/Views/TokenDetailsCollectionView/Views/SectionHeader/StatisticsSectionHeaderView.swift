//
//  StatisticsSectionHeaderView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 27.03.23.
//

import UIKit

class StatisticsSectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "StatisticsSectionHeaderView"

    private enum Constants {
        static let fontHeight: CGFloat = 18.0
        static let font: UIFont = .systemFont(ofSize: fontHeight, weight: .semibold)
        static let leadingOffset: CGFloat = 20.0
        static let centerYOffset: CGFloat = 10.0
    }

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func configure(title: String) {
        titleLabel.text = title
    }
}

private extension StatisticsSectionHeaderView {
    // MARK: - Private methods
    func setupItem() {
        addSubview(titleLabel)
        titleLabel.font = Constants.font

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(Constants.centerYOffset)
            make.leading.equalToSuperview().offset(Constants.leadingOffset)
        }
    }
}
