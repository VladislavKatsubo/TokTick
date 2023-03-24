//
//  AuthViewController.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 7.03.23.
//

import UIKit
import SnapKit

final class AuthViewController: TViewController {

    typealias Constants = AuthResources.Constants.UI

    private let stackView = TStackView(axis: .vertical, spacing: Constants.stackViewSpacing)
    private let loginTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let loginButton = AuthButton()

    private var viewModel: AuthViewModelProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupViewModel()
    }

    // MARK: - Configure
    func configure(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
    }
}

private extension AuthViewController {
    // MARK: - Private methods
    func setupViewModel() {
        viewModel?.setupLoginTextField(completion: { [weak self] login in
            self?.loginTextField.configure(with: login, placeholder: Constants.loginTextFieldPlaceholder)
        })
        viewModel?.setupPasswordTextField(completion: { [weak self] password in
            self?.passwordTextField.configure(with: password, placeholder: Constants.passwordTextFieldPlaceholder)
        })
    }

    func setupItems() {
        setupStackView()
        setupLoginTextField()
        setupPasswordTextField()
        setupButton()
    }

    func setupStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.stackViewInset)
            make.center.equalToSuperview()
        }
    }

    func setupLoginTextField() {
        loginTextField.snp.makeConstraints { make in
            make.height.equalTo(Constants.textFieldHeight)
        }
    }

    func setupPasswordTextField() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(Constants.textFieldHeight)
        }
    }

    func setupButton() {
        loginButton.onTap = { [weak self] in
            let login = self?.loginTextField.text
            let password = self?.passwordTextField.text
            self?.viewModel?.authenticateUser(with: login, and: password)
        }
    }
}
