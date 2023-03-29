//
//  TokenListBalanceView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 23.03.23.
//

import UIKit

final class TokenListBalanceView: TView {
    private enum Constants {
        static let borderWidth: CGFloat = 1.0
        static let borderColor: CGColor = UIColor.black.cgColor
        static let cornerRadius: CGFloat = 25.0

        static let titleLabelFontSize: CGFloat = 16.0
        static let titleLabelFont: UIFont = .systemFont(ofSize: titleLabelFontSize, weight: .semibold)
        static let titleLabelText: String = "My balance"
        static let titleLabelTopOffset: CGFloat = 20.0
        static let titleLabelLeadingOffset: CGFloat = 20.0

        static let balanceLabelFontSize: CGFloat = 24.0
        static let balanceLabelFont: UIFont = .systemFont(ofSize: balanceLabelFontSize, weight: .bold)
        static let balanceLabelTopOffset: CGFloat = 20.0
        static let balanceLabelLeadingOffset: CGFloat = 20.0
        static let balanceLabelBottomOffset: CGFloat = 20.0

        static let skeletonBalanceViewSize: CGSize = .init(width: 70.0, height: 24.0)
    }

    private let titleLabel = UILabel()
    private let balanceLabel = UILabel()
    private let skeletonLabelView = SkeletonView()

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    // MARK: - Configure
    func configure(with balance: Double) {
        fadeAnimation(viewsToHide: [skeletonLabelView, balanceLabel], viewsToShow: [balanceLabel]) {
            self.balanceLabel.text = balance.formatAsCurrency()
            self.skeletonLabelView.stopShimmering()
            self.skeletonLabelView.isHidden = true
            self.balanceLabel.isHidden = false
        }
    }

    func mockfigure() {
        self.balanceLabel.isHidden = true
        self.skeletonLabelView.addShimmering()
    }
}

private extension TokenListBalanceView {
    // MARK: - Private methods
    func setupItems() {
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.borderColor
        layer.cornerRadius = Constants.cornerRadius

        setupTitleLabel()
        setupBalanceLabel()
        setupSkeletonLabelView()
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = Constants.titleLabelFont
        titleLabel.text = Constants.titleLabelText
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.titleLabelTopOffset)
            make.leading.equalToSuperview().offset(Constants.titleLabelLeadingOffset)
        }
    }

    func setupBalanceLabel() {
        addSubview(balanceLabel)
        balanceLabel.font = Constants.balanceLabelFont
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.balanceLabelTopOffset)
            make.leading.equalToSuperview().offset(Constants.balanceLabelLeadingOffset)
            make.bottom.equalToSuperview().inset(Constants.balanceLabelBottomOffset)
        }
    }

    func setupSkeletonLabelView() {
        addSubview(skeletonLabelView)
        skeletonLabelView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.balanceLabelTopOffset)
            make.leading.equalToSuperview().offset(Constants.balanceLabelLeadingOffset)
            make.bottom.equalToSuperview().inset(Constants.balanceLabelBottomOffset)
            make.width.equalTo(Constants.skeletonBalanceViewSize.width)
            make.height.equalTo(Constants.skeletonBalanceViewSize.height)
        }
    }
}
