//
//  AuthViewModel.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 7.03.23.
//

import Foundation

protocol AuthViewModelProtocol {
    func setupLoginTextField(completion: ((String) -> Void))
    func setupPasswordTextField(completion: ((String) -> Void))
    func authenticateUser(with login: String?, and password: String?)
}

final class AuthViewModel: AuthViewModelProtocol {

    private let authService: AuthServiceProtocol?
    private let coordinator: Coordinator?

    // MARK: - Init
    init(authService: AuthServiceProtocol, coordinator: Coordinator) {
        self.authService = authService
        self.coordinator = coordinator
    }

    func setupLoginTextField(completion: ((String) -> Void)) {
        completion(LoginCredentials.login)
    }

    func setupPasswordTextField(completion: ((String) -> Void)) {
        completion(LoginCredentials.password)
    }

    func authenticateUser(with login: String?, and password: String?) {
        authService?.login(username: login, password: password, completion: { [weak self] isLoggedIn in
            switch isLoggedIn {
            case true:
                self?.coordinator?.showMainScreen()
            case false:
                print("Wrong credentials! Re-check them!")
            }
        })
    }
}
