//
//  TCollectionViewCell.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 24.03.23.
//

import UIKit

class TCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constants {

    }

    static var reuseID: String { String(describing: self) }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func didLoad() {

    }
}
