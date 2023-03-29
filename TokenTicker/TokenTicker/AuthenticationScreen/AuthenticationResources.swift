//
//  AuthenticationResources.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import UIKit

struct AuthenticationResources {

    // MARK: - States
    enum State {
        case onMockLoginTextField(AuthTextField.Model)
        case onMockPasswordTextField(AuthTextField.Model)
        case onShowAlert
    }

    // MARK: - Constants
    enum Constants {
        enum UI {
            static let stackViewSpacing: CGFloat = 20.0
            static let stackViewInset: CGFloat = 50.0

            static let textFieldHeight: CGFloat = 50.0

            static let logoImage: UIImage? = UIImage(named: "ticon")
        }

        enum Mocks {
            static let loginTextFieldModel: AuthTextField.Model = .init(
                text: LoginCredentials.login,
                placeholder: "Login"
            )

            static let passwordTextFieldModel: AuthTextField.Model = .init(
                text: LoginCredentials.password,
                placeholder: "Password"
            )
        }
    }
}
