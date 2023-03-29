//
//  AuthenticationViewModel.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 7.03.23.
//

import Foundation

protocol AuthenticationViewModelProtocol {
    func authenticateUser(with login: String?, and password: String?)
    func launch()
    var onStateChange: ((AuthenticationResources.State) -> Void)? { get set }
}

final class AuthenticationViewModel: AuthenticationViewModelProtocol {

    typealias Constants = AuthenticationResources.Constants.Mocks

    private let appContext: AppContext?
    private let coordinator: Coordinator?

    var onStateChange: ((AuthenticationResources.State) -> Void)?

    // MARK: - Init
    init(appContext: AppContext, coordinator: Coordinator) {
        self.appContext = appContext
        self.coordinator = coordinator
    }

    // MARK: - Public methods
    func launch() {
        setupModels()
    }

    func setupModels() {
        mockTextFields()
    }
    
    func authenticateUser(with login: String?, and password: String?) {
        appContext?.authManager.login(username: login, password: password, completion: { [weak self] isLoggedIn in
            switch isLoggedIn {
            case true:
                self?.coordinator?.showMainScreen()
            case false:
                self?.onStateChange?(.onShowAlert)
            }
        })
    }
}

private extension AuthenticationViewModel {
    func mockTextFields() {
        onStateChange?(.onMockLoginTextField(Constants.loginTextFieldModel))
        onStateChange?(.onMockPasswordTextField(Constants.passwordTextFieldModel))
    }
}
