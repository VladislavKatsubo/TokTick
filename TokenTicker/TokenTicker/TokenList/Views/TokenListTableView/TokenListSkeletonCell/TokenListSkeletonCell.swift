//
//  TokenListSkeletonCell.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 18.03.23.
//

import UIKit

class TokenListSkeletonCell: UITableViewCell {
    static var reuseID: String { String(describing: self) }

    private enum Constants {
        static let backgroundColor: UIColor = .white
        static let cornerRadius: CGFloat = 25.0
        static let borderColor: CGColor = UIColor.systemGray4.cgColor
        static let borderWidth: CGFloat = 1.0

        static let leadingOffset: CGFloat = 20.0
        static let centerYOffset: CGFloat = 12.5
        static let trailingInset: CGFloat = 20.0
        static let upperLabelViewHeight: CGFloat = 18.0
        static let lowerLabelViewHeight: CGFloat = 14.0

        static let containerViewBottomInset: CGFloat = 5.0

        static let tokenIconCornerRadius: CGFloat = 20.0
        static let tokenIconHeightMultiplier: CGFloat = 0.65

        static let nameSkeletonViewWidthMultiplier: CGFloat = 1.5

        static let symbolSkeletonViewWidthMultiplier: CGFloat = 0.5

        static let priceWidthMultiplier: CGFloat = 0.8

        static let hourStatisticsTrailingInset: CGFloat = -10.0
        static let statisticsWidthMultiplier: CGFloat = 0.8
    }

    private let containerView = UIView()
    private let tokenIcon = SkeletonView()
    private let nameSkeletonView = SkeletonView()
    private let symbolSkeletonView = SkeletonView()
    private let priceSkeletonView = SkeletonView()
    private let hourStatisticsSkeletonView = SkeletonView()
    private let dayStatisticsSkeletonView = SkeletonView()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TokenListSkeletonCell {
    func setupItems() {
        selectionStyle = .none
        isUserInteractionEnabled = false

        setupContainerView()
        setupTokenIcon()
        setupNameSkeletonView()
        setupSymbolSkeletonView()
        setupPriceSkeletonView()
        setupStatisticsSkeletonViews()
    }

    func setupContainerView() {
        contentView.addSubview(containerView)

        containerView.backgroundColor = Constants.backgroundColor
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.layer.borderColor = Constants.borderColor
        containerView.layer.borderWidth = Constants.borderWidth

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.containerViewBottomInset)
        }
    }

    func setupTokenIcon() {
        containerView.addSubview(tokenIcon)
        tokenIcon.layer.cornerRadius = Constants.tokenIconCornerRadius
        tokenIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.leadingOffset)
            make.height.equalToSuperview().multipliedBy(Constants.tokenIconHeightMultiplier)
            make.width.equalTo(tokenIcon.snp.height)
            make.centerY.equalToSuperview()
        }
    }

    func setupNameSkeletonView() {
        containerView.addSubview(nameSkeletonView)
        nameSkeletonView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-Constants.centerYOffset)
            make.leading.equalTo(tokenIcon.snp.trailing).offset(Constants.leadingOffset)
            make.width.equalTo(tokenIcon.snp.width).multipliedBy(Constants.nameSkeletonViewWidthMultiplier)
            make.height.equalTo(Constants.upperLabelViewHeight)
        }
    }

    func setupSymbolSkeletonView() {
        containerView.addSubview(symbolSkeletonView)
        symbolSkeletonView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(Constants.centerYOffset)
            make.leading.equalTo(tokenIcon.snp.trailing).offset(Constants.leadingOffset)
            make.width.equalTo(nameSkeletonView).multipliedBy(Constants.symbolSkeletonViewWidthMultiplier)
            make.height.equalTo(Constants.lowerLabelViewHeight)
        }
    }

    func setupPriceSkeletonView() {
        containerView.addSubview(priceSkeletonView)
        priceSkeletonView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.trailingInset)
            make.width.equalTo(nameSkeletonView).multipliedBy(Constants.priceWidthMultiplier)
            make.centerY.equalToSuperview().offset(-Constants.centerYOffset)
            make.height.equalTo(Constants.upperLabelViewHeight)
        }
    }

    func setupStatisticsSkeletonViews() {
        containerView.addSubview(hourStatisticsSkeletonView)
        containerView.addSubview(dayStatisticsSkeletonView)
        dayStatisticsSkeletonView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(Constants.centerYOffset)
            make.trailing.equalToSuperview().inset(Constants.trailingInset)
            make.width.equalTo(priceSkeletonView).multipliedBy(Constants.statisticsWidthMultiplier)
            make.height.equalTo(Constants.lowerLabelViewHeight)
        }
        hourStatisticsSkeletonView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(Constants.centerYOffset)
            make.trailing.equalTo(dayStatisticsSkeletonView.snp.leading).inset(Constants.hourStatisticsTrailingInset)
            make.width.equalTo(priceSkeletonView).multipliedBy(Constants.statisticsWidthMultiplier)
            make.height.equalTo(Constants.lowerLabelViewHeight)
        }
    }
}
