//
//  TokenDetailsViewController.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 23.03.23.
//

import UIKit

final class TokenDetailsViewController: TViewController {

    typealias Constants = TokenDetailsResources.Constants.UI

    private let tokenPriceView = TokenPriceView()
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
        viewModel?.onStateChange = { [weak self] state in
            switch state {
            case .onPriceView(let models):
                self?.tokenPriceView.configure(with: models)
            case .onCollectionModels(let models):
                self?.collectionView.configure(with: models)
            case .onSetTitle(let title):
                self?.title = title
            }

        }
        viewModel?.launch()
    }

    func setupItems() {
        setupTokenPriceView()
        setupCollectionView()
    }

    func setupTokenPriceView() {
        view.addSubview(tokenPriceView)
        tokenPriceView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.tokenPriceViewTopOffset)
            make.leading.trailing.equalToSuperview().inset(Constants.tokenPriceViewLeadingTrailingInset)
        }
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tokenPriceView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
