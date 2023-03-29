//
//  AlertManager.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 29.03.23.
//

import UIKit

protocol AlertManagerProtocol {
    func showAlert(ofType type: AlertType, on viewController: UIViewController)
}

enum AlertType {
    case invalidCredentials
    case noInternetConnection
    case logoutConfirmation(logoutAction: () -> Void)
}

struct AlertManager: AlertManagerProtocol {
    func showAlert(ofType type: AlertType, on viewController: UIViewController) {
            let alert: UIAlertController

            switch type {
            case .invalidCredentials:
                alert = createInvalidCredentialsAlert()
            case .noInternetConnection:
                alert = createNoInternetConnectionAlert()
            case .logoutConfirmation(let closure):
                alert = createLogoutConfirmationAlert(on: viewController, completion: closure)
            }

            viewController.present(alert, animated: true)
        }
}

private extension AlertManager {
    func createInvalidCredentialsAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: "Invalid credentials. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }

    func createNoInternetConnectionAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: "No internet connection. Please check your connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }

    func createLogoutConfirmationAlert(on viewController: UIViewController, completion: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { _ in
            completion()
        })
        return alert
    }
}
