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

    private var alertManager: AlertManagerProtocol?
    private var viewModel: TokenListViewModelProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupViewModel()
    }

    // MARK: - Configure
    func configure(viewModel: TokenListViewModelProtocol, alertManager: AlertManagerProtocol) {
        self.viewModel = viewModel
        self.alertManager = alertManager
    }
}

private extension TokenListViewController {
    // MARK: - Private methods
    func setupViewModel() {
        viewModel?.onStateChange = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .onFetchTokens(let tokensData):
                self.tableView.configure(with: tokensData)
            case .onSort(let newIndicies):
                self.tableView.animateSorting(newIndexMapping: newIndicies)
            case .onMockTokenListView:
                self.tableView.mockfigure()
                self.tableViewToolBar.mockfigure()
                self.balanceView.mockfigure()
            case .onAssetTableLabel(let labelText):
                self.tableViewToolBar.configure(with: labelText)
            case .onAccountView(let model):
                self.accountView.configure(with: model)
            case .onBalanceView(let balance):
                self.balanceView.configure(with: balance)
            }
        }
        viewModel?.launch()
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
        stackView.setCustomSpacing(Constants.stackViewCustomSpacingAfterAccountView, after: accountView)
        stackView.addArrangedSubview(balanceView)
        stackView.setCustomSpacing(Constants.stackViewCustomSpacingAfterBalanceView, after: balanceView)
        stackView.addArrangedSubview(tableViewToolBar)
        stackView.setCustomSpacing(Constants.stackViewCustomSpacingAfterTableViewToolBar, after: tableViewToolBar)
        stackView.addArrangedSubview(tableView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.stackViewTopOffset)
            make.leading.trailing.equalToSuperview().inset(Constants.stackViewLeadingTrailingInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setupAccountView() {
        accountView.onTap = { [weak self] in
            guard let self = self else { return }
            self.alertManager?.showAlert(ofType: .logoutConfirmation(logoutAction: {
                self.viewModel?.logout()
            }),on: self)
        }
    }

    func setupTableViewToolBar() {
        tableViewToolBar.onTap = { [weak self] in
            self?.sort()
        }
    }

    func setupTableView() {
        tableView.onTap = { [weak self] token in
            self?.viewModel?.showDetails(for: token)
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
        let alertController = UIAlertController(title: Constants.alertControllerTitle, message: nil, preferredStyle: .actionSheet)

        let hourAscending = UIAlertAction(title: Constants.alertActionHourAscendingTitle, style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .hour, ascending: true)
        }
        let hourDescending = UIAlertAction(title: Constants.alertActionHourDescendingTitle, style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .hour, ascending: false)
        }
        let alphabeticalAscending = UIAlertAction(title: Constants.alertActionAlphabeticalAscendingTitle, style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .alphabetical, ascending: true)
        }
        let alphabeticalDescending = UIAlertAction(title: Constants.alertActionAlphabeticalDescendingTitle, style: .default) { [weak self] _ in
            self?.viewModel?.sort(option: .alphabetical, ascending: false)
        }
        let cancelAction = UIAlertAction(title: Constants.alertControllerCancelActionTitle, style: .cancel)

        alertController.addAction(alphabeticalAscending)
        alertController.addAction(alphabeticalDescending)
        alertController.addAction(hourAscending)
        alertController.addAction(hourDescending)
        alertController.addAction(cancelAction)


        present(alertController, animated: true)
    }
}
