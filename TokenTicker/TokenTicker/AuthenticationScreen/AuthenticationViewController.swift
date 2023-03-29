//
//  AuthenticationViewController.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 7.03.23.
//

import UIKit
import SnapKit

final class AuthenticationViewController: TViewController {

    typealias Constants = AuthenticationResources.Constants.UI

    private let logoImageView = UIImageView()
    private let stackView = TStackView(axis: .vertical, spacing: Constants.stackViewSpacing)
    private let loginTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let loginButton = AuthButton()

    private var alertManager: AlertManagerProtocol?
    private var viewModel: AuthenticationViewModelProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupViewModel()
    }

    // MARK: - Configure
    func configure(viewModel: AuthenticationViewModelProtocol, alertManager: AlertManagerProtocol) {
        self.viewModel = viewModel
        self.alertManager = alertManager
    }
}

private extension AuthenticationViewController {
    // MARK: - Private methods
    func setupViewModel() {
        self.viewModel?.onStateChange =  { [weak self] states in
            guard let self = self else { return }

            switch states {
            case .onMockLoginTextField(let model):
                self.loginTextField.configure(with: model)
            case .onMockPasswordTextField(let model):
                self.passwordTextField.configure(with: model)
            case .onShowAlert:
                self.alertManager?.showAlert(ofType: .invalidCredentials, on: self)
            }
        }
        self.viewModel?.launch()
    }

    func setupItems() {
        setupStackView()
        setupLogoImageView()
        setupLoginTextField()
        setupPasswordTextField()
        setupButton()
    }

    func setupLogoImageView() {
        logoImageView.image = Constants.logoImage
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(stackView.snp.width)
            make.height.equalTo(logoImageView.snp.width)
        }
    }

    func setupStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
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
