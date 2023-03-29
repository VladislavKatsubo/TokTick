//
//  TokenListAccountView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 22.03.23.
//

import UIKit


final class TokenListAccountView: TView {
    private enum Constants {
        static let imageViewSize: CGSize = .init(width: 20.0, height: 20.0)
        static let leadingOffset: CGFloat = 20.0
        static let imageViewtopOffset: CGFloat = 20.0

        static let iconViewCornerRadius: CGFloat = 25.0
        static let iconViewBorderColor: CGColor = UIColor.black.cgColor
        static let iconViewBorderWidth: CGFloat = 1.0

        static let stackViewTrailingOffset: CGFloat = 10.0

        static let accountTypeLabelFont: UIFont = .systemFont(ofSize: 14.0)
        static let accountTypeLabelTextColor: UIColor = .gray

        static let userNameLabelFont: UIFont = .systemFont(ofSize: 18.0, weight: .semibold)

        static let logoutButtonInset: CGFloat = 20.0
        static let logoutButtonHeight: CGFloat = 24.0
    }

    private let containerView = TView()
    private let iconView = AccountIconView()
    private let stackView = TStackView(axis: .vertical, distribution: .fill)
    private let accountTypeLabel = UILabel()
    private let userNameLabel = UILabel()
    private let balanceLabel = UILabel()
    private let logoutButton = AccountLogoutButton()

    var onTap: (() -> Void)?

    // MARK: - Configure
    func configure(with model: TokenListAccountView.Model) {
        self.iconView.configure(with: model.image)
        self.accountTypeLabel.text = model.accountType.rawValue
        self.userNameLabel.text = model.userName
        self.balanceLabel.text = String(model.balance)
    }

    // MARK: - Public methods
    override func didLoad() {
        setupItems()
    }
}

private extension TokenListAccountView {
    // MARK: - Private methods
    func setupItems() {
        backgroundColor = .white

        setupImageView()
        setupStackView()
        setupAccountTypeLabel()
        setupUserNameLabel()
        setupLogoutButton()
    }

    func setupImageView() {
        addSubview(iconView)
        iconView.layer.cornerRadius = Constants.iconViewCornerRadius
        iconView.layer.borderColor = Constants.iconViewBorderColor
        iconView.layer.borderWidth = Constants.iconViewBorderWidth
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.leadingOffset)
            make.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(accountTypeLabel)
        stackView.addArrangedSubview(userNameLabel)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.top)
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.stackViewTrailingOffset)
            make.bottom.equalTo(iconView.snp.bottom)
        }
    }

    func setupAccountTypeLabel() {
        accountTypeLabel.font = Constants.accountTypeLabelFont
        accountTypeLabel.textColor = Constants.accountTypeLabelTextColor
    }

    func setupUserNameLabel() {
        userNameLabel.font = Constants.userNameLabelFont
    }

    func setupLogoutButton() {
        addSubview(logoutButton)
        logoutButton.onTap = { [weak self] in
            self?.onTap?()
        }
        logoutButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constants.logoutButtonInset)
            make.width.height.equalTo(Constants.logoutButtonHeight)
        }
    }
}
