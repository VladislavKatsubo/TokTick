//
//  AuthTextField.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 7.03.23.
//

import UIKit

final class AuthTextField: UIView {

    private let textField = TTextField()

    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }

    var text: String? {
        textField.text
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure
    func configure(with model: Model) {
        textField.configure(with: model.text, placeholder: model.placeholder)
    }
}

private extension AuthTextField {
    // MARK: - Private
    func setupItems() {
        setupTextField()
    }

    func setupTextField() {
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
