//
//  AccountLogoutButton.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 23.03.23.
//

import UIKit

final class AccountLogoutButton: TButton {
    private enum Constants {
        static let image = UIImage(
            systemName: "iphone.and.arrow.forward"
        )?.withTintColor(
            .black,
            renderingMode: .alwaysOriginal
        )
    }

    // MARK: - Public methods
    override func didLoad() {
        super.didLoad()
        setImage(Constants.image, for: .normal)
    }
}
