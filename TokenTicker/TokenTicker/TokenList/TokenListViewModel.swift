//
//  TokenListViewModel.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import Foundation

protocol TokenListViewModelProtocol {
    func launch()
    func logout()
    func sort(option: TokenListViewModel.SortingOptions, ascending: Bool)
    func showDetails(for coin: Asset)


    var onFetchCoins: (([Asset]) -> Void)? { get set }
    var onSort: (([IndexPath: IndexPath]) -> Void)? { get set }
    var onMockTokenListView: (() -> Void)? { get set }
    var onAssetTableLabel: ((String) -> Void)? { get set }
    var onAccountView: ((TokenListAccountView.Model) -> Void)? { get set }
    var onBalanceView: ((Double) -> Void)? { get set }
}

final class TokenListViewModel: TokenListViewModelProtocol {

    typealias Constants = TokenListResources.Constants.Mocks

    private let coordinator: Coordinator
    private let appContext: AppContext

    private var coinsData: [Asset] = []

    var onFetchCoins: (([Asset]) -> Void)?
    var onSort: (([IndexPath: IndexPath]) -> Void)?
    var onMockTokenListView: (() -> Void)?
    var onAssetTableLabel: ((String) -> Void)?
    var onAccountView: ((TokenListAccountView.Model) -> Void)?
    var onBalanceView: ((Double) -> Void)?

    // MARK: - Init
    init(coordinator: Coordinator, appContext: AppContext) {
        self.coordinator = coordinator
        self.appContext = appContext
    }

    // MARK: - Public methods
    func launch() {
        fetchAllCoinsData()
        setupTableViewMockData()
        setupAccountView()
//        mockBalanceViewLabelLoading()
//        mockAssetTableLabelLoading()
    }

    func fetchAllCoinsData() {
//        coinsData = Constants.assets
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
//            guard let self = self else { return }
//            self.onFetchCoins?(self.coinsData)
//        }
        let group = DispatchGroup()

        Coins.allCases.forEach({ [weak self] in
            guard let url = $0.url else { return }
            group.enter()
            self?.appContext.networkManager.fetchData(url: url, expecting: Asset.self, completion: { result in
                defer { group.leave()}
                switch result {
                case .success(let coinData):
                    self?.coinsData.append(coinData)
                case .failure(let error):
                    print(error)
                }
            })
        })

        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }

            self.onFetchCoins?(self.coinsData)
            self.onAssetTableLabel?("\(String(describing: self.coinsData.count)) Assets")
            self.onBalanceView?(Constants.mockUserModel.balance)
        }
    }

    func showDetails(for token: Asset) {
        self.coordinator.showDetailScreen(for: token)
    }

    func logout() {
        coordinator.logout()
    }

    func sort(option: SortingOptions, ascending: Bool) {
        let initialIndexMapping: [IndexPath: Asset] = Dictionary(uniqueKeysWithValues: zip(coinsData.indices.map { IndexPath(row: $0, section: 0) }, coinsData))

        switch option {
        case .hour:
            coinsData.sort {
                let lhs = $0.data.marketData.percentChangeUsdLast1Hour ?? 0
                let rhs = $1.data.marketData.percentChangeUsdLast1Hour ?? 0
                return ascending ? lhs < rhs : lhs > rhs
            }
        case .day:
            coinsData.sort {
                let lhs = $0.data.marketData.percentChangeUsdLast24Hours ?? 0
                let rhs = $1.data.marketData.percentChangeUsdLast24Hours ?? 0
                return ascending ? lhs < rhs : lhs > rhs
            }
        case .alphabetical:
            coinsData.sort {
                let lhs = $0.data.name
                let rhs = $1.data.name
                return ascending ? lhs < rhs : lhs > rhs
            }
        }

        let newIndexMapping: [IndexPath: IndexPath] = initialIndexMapping.compactMapValues { asset in
            coinsData.firstIndex(where: { $0 == asset }).map { IndexPath(row: $0, section: 0) }
        }

        onSort?(newIndexMapping)
    }
}

private extension TokenListViewModel {
    // MARK: - Private methods
    func setupTableViewMockData() {
        onMockTokenListView?()
    }

    func mockAssetTableLabelLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.onAssetTableLabel?("\(self.coinsData.count) Assets")
        }
    }

    func mockBalanceViewLabelLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.onBalanceView?(Constants.mockUserModel.balance)
        }
    }

    func setupAccountView() {
        onAccountView?(Constants.mockUserModel)
    }
}

extension TokenListViewModel {
    enum SortingOptions {
        case hour
        case day
        case alphabetical
    }
}
