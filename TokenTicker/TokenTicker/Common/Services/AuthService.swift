//
//  AuthService.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import Foundation

protocol AuthServiceProtocol {
    func isLoggedIn() -> Bool
    func login(username: String?, password: String?, completion: @escaping (Bool) -> Void)
    func logout()
}

class UserDefaultsAuthService: AuthServiceProtocol {
    private let userDefaults = UserDefaults.standard

    func isLoggedIn() -> Bool {
        return userDefaults.bool(forKey: "isLoggedIn")
    }

    func login(username: String?, password: String?, completion: @escaping (Bool) -> Void) {
        guard username == LoginCredentials.login,
              password == LoginCredentials.password else {

            userDefaults.set(false, forKey: "isLoggedIn")
            completion(false)
            
            return print("Wrong credentials")
        }

        userDefaults.set(true, forKey: "isLoggedIn")
        completion(true)
    }

    func logout() {
        userDefaults.set(false, forKey: "isLoggedIn")
    }
}
