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
    let appContext: AppContext
    var navigationController: UINavigationController?

    init(window: UIWindow, appContext: AppContext) {
        self.window = window
        self.appContext = appContext
    }

    func start() {
        guard appContext.authManager.isLoggedIn() else {
            showLoginScreen()
            return
        }
        showMainScreen()
    }

    func logout() {
        appContext.authManager.logout()
        showLoginScreen()
    }

    func showLoginScreen() {
        let viewModel = AuthenticationViewModel(appContext: appContext, coordinator: self)
        let viewController = AuthenticationViewController()
        viewController.configure(viewModel: viewModel, alertManager: appContext.alertManager)

        self.window.rootViewController = viewController
        self.window.makeKeyAndVisible()
    }

    func showMainScreen() {
        let viewModel = TokenListViewModel(coordinator: self, appContext: appContext)
        let viewController = TokenListViewController()
        viewController.configure(viewModel: viewModel, alertManager: appContext.alertManager)

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
