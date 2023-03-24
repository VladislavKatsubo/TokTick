//
//  TokenListResources.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import Foundation

struct TokenListResources {
//    // MARK: - Handlers
//    struct Handlers {
//        var onAddNewPin: () -> Void
//    }

    // MARK: - States
    enum State {
        case onSort(Bool)
        case onMockTableViewData
    }

    enum Constants {

        enum UI {
        }

        enum Mocks {
            static let mockUserModel: TokenListAccountView.Model = .init(
                userName: "Vladislav Katsubo",
                accountType: .personal,
                image: .init(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal),
                balance: 41231.55
            )
        }
    }
}
