//
//  TokenListViewModel.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import Foundation

protocol TokenListViewModelProtocol {
    var onStateChange: ((TokenListResources.State) -> Void)? { get set }

    func launch()
    func logout()
    func sort(option: TokenListViewModel.SortingOptions, ascending: Bool)
    func showDetails(for token: Asset)
}

final class TokenListViewModel: TokenListViewModelProtocol {

    typealias Constants = TokenListResources.Constants.Mocks

    private let coordinator: Coordinator
    private let appContext: AppContext

    private var tokens: [Asset] = []

    var onStateChange: ((TokenListResources.State) -> Void)?

    // MARK: - Init
    init(coordinator: Coordinator, appContext: AppContext) {
        self.coordinator = coordinator
        self.appContext = appContext
    }

    // MARK: - Public methods
    func launch() {
        fetchAllTokens()
        setupTableViewMockData()
        setupAccountView()
    }

    func fetchAllTokens() {
        let group = DispatchGroup()

        Tokens.allCases.forEach({ [weak self] in
            guard let url = APIEndpoint.metrics(token: $0.info).url else { return }
            group.enter()
            self?.appContext.networkManager.fetchData(url: url, expecting: Asset.self, completion: { result in
                defer { group.leave()}
                switch result {
                case .success(let token):
                    self?.tokens.append(token)
                case .failure(let error):
                    print(error)
                }
            })
        })

        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }

            self.onStateChange?(.onFetchTokens(self.tokens))
            self.onStateChange?(.onAssetTableLabel("\(String(describing: self.tokens.count)) Assets"))
            self.onStateChange?(.onBalanceView(Constants.mockUserModel.balance))
        }
    }

    func showDetails(for token: Asset) {
        coordinator.showDetailScreen(for: token)
    }

    func logout() {
        coordinator.logout()
    }

    func sort(option: SortingOptions, ascending: Bool) {
        let initialIndexMapping: [IndexPath: Asset] = Dictionary(uniqueKeysWithValues: zip(tokens.indices.map { IndexPath(row: $0, section: 0) }, tokens))

        switch option {
        case .hour:
            tokens.sort {
                let lhs = $0.data.marketData.percentChangeUsdLast1Hour ?? 0
                let rhs = $1.data.marketData.percentChangeUsdLast1Hour ?? 0
                return ascending ? lhs < rhs : lhs > rhs
            }
        case .alphabetical:
            tokens.sort {
                let lhs = $0.data.name
                let rhs = $1.data.name
                return ascending ? lhs < rhs : lhs > rhs
            }
        }

        let newIndexMapping: [IndexPath: IndexPath] = initialIndexMapping.compactMapValues { asset in
            tokens.firstIndex(where: { $0 == asset }).map { IndexPath(row: $0, section: 0) }
        }

        onStateChange?(.onSort(newIndexMapping))
    }
}

private extension TokenListViewModel {
    // MARK: - Private methods
    func setupTableViewMockData() {
        onStateChange?(.onMockTokenListView)
    }

    func setupAccountView() {
        onStateChange?(.onAccountView(Constants.mockUserModel))
    }
}

extension TokenListViewModel {
    enum SortingOptions {
        case hour
        case alphabetical
    }
}
