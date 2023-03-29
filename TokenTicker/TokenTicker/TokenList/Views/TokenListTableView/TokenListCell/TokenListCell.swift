//
//  TokenListCell.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import UIKit

final class TokenListCell: UITableViewCell {
    static var reuseID: String { String(describing: self) }

    private enum Constants {
        static let containerViewCornerRadius: CGFloat = 25.0
        static let containerViewBorderColor: CGColor = UIColor.black.cgColor
        static let containerViewBorderWidth: CGFloat = 1.0
        static let containerViewBottomInset: CGFloat = 5.0

        static let tokenIconLeadingOffset: CGFloat = 10.0
        static let tokenIconHeightMultiplier: CGFloat = 0.75

        static let tokenSymbolNameTopOffset: CGFloat = 20.0
        static let tokenSymbolNameLeadingOffset: CGFloat = 10.0
        static let tokenSymbolNameBottomOffset: CGFloat = 20.0

        static let tokenMarketDataTopOffset: CGFloat = 20.0
        static let tokenMarketDataTrailingOffset: CGFloat = 20.0
    }

    private let containerView = TView()
    private let tokenIconView = TokenIconView()
    private let tokenSymbolNameView = TokenSymbolNameView()
    private let tokenMarketDataView = TokenMarketDataView()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cleanup()
    }

    // MARK: - Configure
    func configure(with token: Asset, isRealData: Bool) {
        self.tokenIconView.configure(with: token.data.name)
        self.tokenSymbolNameView.configure(with: token)
        self.tokenMarketDataView.configure(with: token)
    }
}

private extension TokenListCell {
    // MARK: - Private methods
    func setupItems() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        
        setupContainerView()
        setupTokenIcon()
        setupTokenSymbolName()
        setupTokenMarketData()
    }

    func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.layer.cornerRadius = Constants.containerViewCornerRadius
        containerView.layer.borderColor = Constants.containerViewBorderColor
        containerView.layer.borderWidth = Constants.containerViewBorderWidth
        containerView.backgroundColor = .white

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.containerViewBottomInset)
        }
    }

    func setupTokenIcon() {
        containerView.addSubview(tokenIconView)
        tokenIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.tokenIconLeadingOffset)
            make.height.equalToSuperview().multipliedBy(Constants.tokenIconHeightMultiplier)
            make.width.equalTo(tokenIconView.snp.height)
            make.centerY.equalToSuperview()
        }
    }

    func setupTokenSymbolName() {
        containerView.addSubview(tokenSymbolNameView)
        tokenSymbolNameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.tokenSymbolNameTopOffset)
            make.leading.equalTo(tokenIconView.snp.trailing).offset(Constants.tokenSymbolNameLeadingOffset)
            make.bottom.equalToSuperview().inset(Constants.tokenSymbolNameBottomOffset)
        }
    }

    func setupTokenMarketData() {
        containerView.addSubview(tokenMarketDataView)
        tokenMarketDataView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.tokenMarketDataTopOffset)
            make.trailing.equalToSuperview().inset(Constants.tokenMarketDataTrailingOffset)
            make.top.equalToSuperview().offset(Constants.tokenMarketDataTopOffset)
        }
    }

    func cleanup() {
        self.tokenIconView.reset()
        self.tokenSymbolNameView.reset()
        self.tokenMarketDataView.reset()
    }
}
