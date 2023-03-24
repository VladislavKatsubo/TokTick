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
    func fetchAllCoinsData(completion: @escaping ([Asset]) -> Void)
    func sort(option: TokenListViewModel.SortingOptions, ascending: Bool)
    func showDetails(for coin: Asset)



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
        setupTableViewMockData()
        setupAssetTableLable()
        setupAccountView()
        setupBalanceView()
    }

    func fetchAllCoinsData(completion: @escaping ([Asset]) -> Void) {
        let assets: [Asset] = [
            Asset(data: Asset.AssetData(name: "Bitcoin", symbol: "BTC", marketData: Asset.AssetData.MarketData(priceUsd: 25000.921529520783, percentChangeUsdLast1Hour: 1.2990327694951016, percentChangeUsdLast24Hours: 23.57694951))),
            Asset(data: Asset.AssetData(name: "Ethereum", symbol: "ETH", marketData: Asset.AssetData.MarketData(priceUsd: 2500.921529520783, percentChangeUsdLast1Hour: -1.2990327694951016, percentChangeUsdLast24Hours: -3.57694951))),
            Asset(data: Asset.AssetData(name: "Tron", symbol: "TRX", marketData: Asset.AssetData.MarketData(priceUsd: 25.921529520783, percentChangeUsdLast1Hour: 0, percentChangeUsdLast24Hours: 13.57694951))),
            Asset(data: Asset.AssetData(name: "Luna", symbol: "LUNA", marketData: Asset.AssetData.MarketData(priceUsd: 250.921529520783, percentChangeUsdLast1Hour: 2.2990327694951016, percentChangeUsdLast24Hours: -33.57694951))),
            Asset(data: Asset.AssetData(name: "Polkadot", symbol: "DOT", marketData: Asset.AssetData.MarketData(priceUsd: 2500.921529520783, percentChangeUsdLast1Hour: 4.2990327694951016, percentChangeUsdLast24Hours: 43.57694951))),
            Asset(data: Asset.AssetData(name: "Cordana", symbol: "ADA", marketData: Asset.AssetData.MarketData(priceUsd: 5.921529520783, percentChangeUsdLast1Hour: 3.2990327694951016, percentChangeUsdLast24Hours: -333.57694951)))
        ]
        coinsData = assets
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else { return }
            completion(self.coinsData)
        }
        //        let group = DispatchGroup()
        //
        //        Coins.allCases.forEach({ [weak self] in
        //            guard let url = $0.url else { return }
        //            group.enter()
        //            self?.appContext.networkManager.fetchData(url: url, expecting: Asset.self, completion: { result in
        //                defer { group.leave()}
        //                switch result {
        //                case .success(let coinData):
        //                    self?.coinsData.append(coinData)
        //                case .failure(let error):
        //                    print(error)
        //                }
        //            })
        //        })
        //
        //        group.notify(queue: .main) { [weak self] in
        //            completion(self?.coinsData ?? [])
        //        }
    }

    func showDetails(for coin: Asset) {
        print(coin.data.name)
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

    func setupAssetTableLable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else { return }
            self.onAssetTableLabel?("\(self.coinsData.count) Assets")
        }
    }

    func setupAccountView() {
        onAccountView?(Constants.mockUserModel)
    }

    func setupBalanceView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.onBalanceView?(Constants.mockUserModel.balance)
        }
    }
}

extension TokenListViewModel {
    enum SortingOptions {
        case hour
        case day
        case alphabetical
    }
}
