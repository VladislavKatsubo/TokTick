//
//  MainCoordinator.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
    func logout()
    func showLoginScreen()
    func showMainScreen()
    func showDetailScreen(for token: Asset)
}

final class MainCoordinator: Coordinator {

    let window: UIWindow
    let authService: UserDefaultsAuthService
    var navigationController: UINavigationController?

    init(window: UIWindow, authService: UserDefaultsAuthService) {
        self.window = window
        self.authService = authService
    }

    func start() {
        guard authService.isLoggedIn() else {
            showLoginScreen()
            return
        }
        showMainScreen()
    }

    func logout() {
        authService.logout()
        showLoginScreen()
    }

    func showLoginScreen() {
        let viewModel = AuthViewModel(authService: authService, coordinator: self)
        let viewController = AuthViewController()
        viewController.configure(viewModel: viewModel)

        self.window.rootViewController = viewController
        self.window.makeKeyAndVisible()
    }

    func showMainScreen() {
        let urlSession = URLSession(configuration: .default)
        let networkManager = NetworkManager(session: urlSession)
        let appContext = AppContext(authService: authService, networkManager: networkManager)
        let viewModel = TokenListViewModel(coordinator: self, appContext: appContext)
        let viewController = TokenListViewController()
        viewController.configure(viewModel: viewModel)

        navigationController = UINavigationController(rootViewController: viewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func showDetailScreen(for token: Asset) {
        let viewModel = TokenDetailsViewModel(token: token)
        let viewController = TokenDetailsViewController()
        viewController.configure(viewModel: viewModel)

        navigationController?.pushViewController(viewController, animated: true)
    }
}
