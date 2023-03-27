//
//  TCollectionView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 24.03.23.
//

import UIKit

class TCollectionView: UICollectionView {

    // MARK: - Init
    init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func registerCells(_ cells: [TCollectionViewCell.Type]) {
        cells.forEach({ register($0, forCellWithReuseIdentifier: $0.reuseID) })
    }
}

private extension TCollectionView {
    // MARK: - Private methods
    func setupItems() {
        backgroundColor = .clear
    }
}
