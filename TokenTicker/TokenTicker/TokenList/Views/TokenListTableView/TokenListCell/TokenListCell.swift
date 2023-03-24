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

    // MARK: - Configure
    func configure(with coin: Asset, isRealData: Bool) {
        self.tokenIconView.configure(with: coin.data.symbol)
        self.tokenSymbolNameView.configure(with: coin)
        self.tokenMarketDataView.configure(with: coin)
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
        containerView.layer.cornerRadius = 25.0
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.backgroundColor = .white

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(5.0)
        }
    }

    func setupTokenIcon() {
        containerView.addSubview(tokenIconView)
        tokenIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10.0)
            make.height.equalToSuperview().multipliedBy(0.75)
            make.width.equalTo(tokenIconView.snp.height)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupTokenSymbolName() {
        containerView.addSubview(tokenSymbolNameView)
        tokenSymbolNameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.0)
            make.leading.equalTo(tokenIconView.snp.trailing).offset(10.0)
            make.bottom.equalToSuperview().inset(20.0)
        }
    }

    func setupTokenMarketData() {
        containerView.addSubview(tokenMarketDataView)
        tokenMarketDataView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().inset(20.0)
            make.top.equalToSuperview().offset(20.0)
        }
    }
}
