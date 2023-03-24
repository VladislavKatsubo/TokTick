//
//  TokenListAccountView+Model.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 22.03.23.
//

import UIKit

extension TokenListAccountView {
    struct Model {
        let userName: String
        let accountType: AccountType
        let image: UIImage?
        let balance: Double

        enum AccountType: String {
            case personal = "Personal Account"
            case business = "Business Account"
        }
    }
}
