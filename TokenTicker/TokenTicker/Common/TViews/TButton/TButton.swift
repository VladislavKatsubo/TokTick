//
//  TButton.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 8.03.23.
//

import UIKit

class TButton: UIButton {

    var onTap: (() -> Void)?

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 0.5
            } else {
                alpha = 1.0
            }
        }
    }

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        didLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func didLoad() {
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
}

private extension TButton {
    @objc
    func didTap() {
        onTap?()
    }
}
