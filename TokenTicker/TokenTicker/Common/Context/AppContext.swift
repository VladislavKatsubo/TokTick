//
//  AppContext.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 12.03.23.
//

import Foundation

final class AppContext {
//    let alertService: AlertService
    let authService: AuthServiceProtocol
    let networkManager: NetworkManagerProtocol

    init(authService: AuthServiceProtocol, networkManager: NetworkManagerProtocol) {
        self.authService = authService
        self.networkManager = networkManager
    }

//    static func context() -> AppContext {
//
//    }
}
