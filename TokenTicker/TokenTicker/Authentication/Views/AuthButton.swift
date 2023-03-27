//
//  AuthButton.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import UIKit

final class AuthButton: TButton {

    // MARK: - Constants
    private enum Constants {
        static let borderColor: CGColor = UIColor.black.cgColor
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 10.0

        static let font: UIFont = .systemFont(ofSize: 18.0, weight: .regular)
        static let titleColor: UIColor = .black
        static let title: String = "Log In"
    }

    // MARK: - Init
    override init() {
        super.init()
    }

    init(with title: String) {
        super.init()
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    override func didLoad() {
        super.didLoad()
        setupItems()
    }
}

private extension AuthButton {
    // MARK: - Private methods
    func setupItems() {
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.borderColor
        layer.cornerRadius = Constants.cornerRadius

        titleLabel?.font = Constants.font
        titleColor = Constants.titleColor
        title = Constants.title
        self.snp.makeConstraints { make in
            make.height.equalTo(50.0)
        }
    }
}
