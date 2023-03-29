//
//  AppContext.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 12.03.23.
//

import Foundation

struct AppContext {
    let alertManager: AlertManagerProtocol
    let authManager: AuthenticationManagerProtocol
    let networkManager: NetworkManagerProtocol

    static func context() -> AppContext {
        let alertManager = AlertManager()
        let authManager = AuthenticationManager()
        let urlSession = URLSession(configuration: .default)
        let networkManager = NetworkManager(session: urlSession)

        return AppContext(
            alertManager: alertManager,
            authManager: authManager,
            networkManager: networkManager
        )
    }
}
