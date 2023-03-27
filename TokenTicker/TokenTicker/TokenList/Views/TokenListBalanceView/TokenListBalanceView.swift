//
//  TokenListBalanceView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 23.03.23.
//

import UIKit

final class TokenListBalanceView: TView {
    private enum Constants {
        static let titleLabelFontSize: CGFloat = 16.0
        static let titleLabelFont: UIFont = .systemFont(ofSize: Constants.titleLabelFontSize, weight: .semibold)
        static let titleLabelText: String = "My balance"

        static let balanceLabelFontSize: CGFloat = 24.0
        static let balanceLabelFont: UIFont = .systemFont(ofSize: Constants.balanceLabelFontSize, weight: .bold)

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
        UIView.animate(withDuration: 0.75, animations: {
            self.skeletonLabelView.alpha = 0.0
            self.balanceLabel.alpha = 0.0
        }) { _ in
            self.balanceLabel.text = balance.formatAsCurrency()
            self.skeletonLabelView.stopShimmering()
            self.skeletonLabelView.isHidden = true
            self.balanceLabel.isHidden = false
            UIView.animate(withDuration: 0.75) {
                self.balanceLabel.alpha = 1.0
            }
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
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 25.0

        setupTitleLabel()
        setupBalanceLabel()
        setupSkeletonLabelView()
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = Constants.titleLabelFont
        titleLabel.text = Constants.titleLabelText
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
        }
    }

    func setupBalanceLabel() {
        addSubview(balanceLabel)
        balanceLabel.font = Constants.balanceLabelFont
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
            make.bottom.equalToSuperview().inset(20.0)
        }
    }

    func setupSkeletonLabelView() {
        addSubview(skeletonLabelView)
        skeletonLabelView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
            make.bottom.equalToSuperview().inset(20.0)
            make.width.equalTo(Constants.skeletonBalanceViewSize.width)
            make.height.equalTo(Constants.skeletonBalanceViewSize.height)
        }
    }
}
