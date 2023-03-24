//
//  TokenListViewController.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import UIKit

final class TokenListViewController: TViewController {

    typealias Constants = TokenListResources.Constants.UI

    private let stackView = TStackView(axis: .vertical, distribution: .fill)
    private let accountView = TokenListAccountView()
    private let balanceView = TokenListBalanceView()
    private let tableViewToolBar = TokenListTableViewToolbar()
    private let tableView = TokenListTableView()

    private var viewModel: TokenListViewModelProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupViewModel()
    }

    // MARK: - Configure
    func configure(viewModel: TokenListViewModelProtocol) {
        self.viewModel = viewModel
    }
}

private extension TokenListViewController {
    // MARK: - Private methods
    func setupViewModel() {
        self.viewModel?.onMockTokenListView = { [weak self] in
            self?.tableView.mockfigure()
            self?.tableViewToolBar.mockfigure()
            self?.balanceView.mockfigure()
        }
        self.viewModel?.onAccountView = { [weak self] model in
            self?.accountView.configure(with: model)
        }
        self.viewModel?.onBalanceView = { [weak self] balance in
            self?.balanceView.configure(with: balance)
        }
        self.viewModel?.onAssetTableLabel = { [weak self] labelText in
            self?.tableViewToolBar.configure(with: labelText)
        }
        self.viewModel?.fetchAllCoinsData(completion: { [weak self] coins in
            self?.tableView.configure(with: coins)
        })
        self.viewModel?.onSort = { [weak self] newIndicies in
            self?.tableView.animateSorting(newIndexMapping: newIndicies)
        }
        self.viewModel?.launch()
    }

    func setupItems() {
        setupStackView()
        setupAccountView()
        setupTableViewToolBar()
        setupTableView()
    }

    func setupStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(accountView)
        stackView.setCustomSpacing(30.0, after: accountView)
        stackView.addArrangedSubview(balanceView)
        stackView.setCustomSpacing(30.0, after: balanceView)
        stackView.addArrangedSubview(tableViewToolBar)
        stackView.setCustomSpacing(10.0, after: tableViewToolBar)
        stackView.addArrangedSubview(tableView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            make.leading.trailing.equalToSuperview().inset(20.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setupAccountView() {
        accountView.onTap = { [weak self] in
            self?.viewModel?.logout()
        }
    }

    func setupTableViewToolBar() {
        tableViewToolBar.onTap = { [weak self] in
            self?.sort()
        }
    }

    func setupTableView() {
        tableView.onTap = { [weak self] coin in
            self?.viewModel?.showDetails(for: coin)
        }
    }
}

private extension TokenListViewController {
    // MARK: - Sorting
    @objc
    func sort() {
        self.presentSortingOptions()
    }

    
    func presentSortingOptions() {
        let alertController = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)

        let hourAscending = UIAlertAction(title: "Hour: Ascending", style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .hour, ascending: true)
        }
        let hourDescending = UIAlertAction(title: "Hour: Descending", style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .hour, ascending: false)
        }
        let dayAscending = UIAlertAction(title: "Day: Ascending", style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .day, ascending: true)
        }
        let dayDescending = UIAlertAction(title: "Day: Descending", style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .day, ascending: false)
        }
        let alphabeticalAscending = UIAlertAction(title: "Alphabetical: A-Z", style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .alphabetical, ascending: true)
        }
        let alphabeticalDescending = UIAlertAction(title: "Alphabetical: Z-A", style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .alphabetical, ascending: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(alphabeticalAscending)
        alertController.addAction(alphabeticalDescending)
        alertController.addAction(hourAscending)
        alertController.addAction(hourDescending)
        alertController.addAction(dayAscending)
        alertController.addAction(dayDescending)
        alertController.addAction(cancelAction)


        present(alertController, animated: true)
    }
}
