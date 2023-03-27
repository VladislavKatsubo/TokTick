//
//  TokenDetailsViewController.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 23.03.23.
//

import UIKit

final class TokenDetailsViewController: TViewController {

    typealias Constants = TokenDetailsResources.Constants.UI

    private let collectionView = TokenDetailsCollectionView()

    private var viewModel: TokenDetailsViewModelProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupViewModel()
        view.backgroundColor = .white
    }

    // MARK: - Configure
    func configure(viewModel: TokenDetailsViewModelProtocol) {
        self.viewModel = viewModel
    }
}

private extension TokenDetailsViewController {
    // MARK: - Private methods
    func setupViewModel() {
        self.viewModel?.onCollectionModels = { [weak self] models in
            self?.collectionView.configure(with: models)
        }
        self.viewModel?.onSetTitle = { [weak self] title in
            self?.title = title
        }
        self.viewModel?.launch()
    }

    func setupItems() {
        setupCollectionView()
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
