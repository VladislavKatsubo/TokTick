//
//  TokenListTableView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import UIKit

final class TokenListTableView: TView {

    private enum Constants {
        static let mockCellsCount: Int = 8
    }

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var coins: [Asset] = [] {
        didSet {
            isRealData = true
        }
    }

    private var isRealData: Bool = false

    var onTap: ((Asset) -> Void)?

    // MARK: - Configure
    func configure(with coins: [Asset]) {
        self.coins = coins
        self.tableView.reloadDataWithAnimation()
        self.tableView.isUserInteractionEnabled = true
    }

    func mockfigure() {
        self.tableView.reloadData()
        self.tableView.isUserInteractionEnabled = false
    }

    // MARK: - Public methods
    override func didLoad() {
        super.didLoad()
        setupTableView()
    }

    func animateSorting(newIndexMapping: [IndexPath: IndexPath]) {
        self.tableView.beginUpdates()
        newIndexMapping.forEach { oldIndexPath, newIndexPath in
            self.tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        }
        self.tableView.endUpdates()

        var updatedCoins = coins
        newIndexMapping.forEach { oldIndexPath, newIndexPath in
            updatedCoins[newIndexPath.row] = coins[oldIndexPath.row]
        }
        self.coins = updatedCoins
    }
}

private extension TokenListTableView {
    // MARK: - Private methods
    func setupTableView() {
        addSubview(tableView)
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TokenListCell.self, forCellReuseIdentifier: TokenListCell.reuseID)
        tableView.register(TokenListSkeletonCell.self, forCellReuseIdentifier: TokenListSkeletonCell.reuseID)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension TokenListTableView: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTap?(coins[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let reuseIdentifier = isRealData ? TokenListCell.reuseID : TokenListSkeletonCell.reuseID
        if reuseIdentifier == TokenListSkeletonCell.reuseID {
            return 90.0
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension TokenListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isRealData ? coins.count : Constants.mockCellsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard isRealData else {
            guard let skeletonCell = tableView.dequeueReusableCell(
                withIdentifier: TokenListSkeletonCell.reuseID,
                for: indexPath
            ) as? TokenListSkeletonCell else {
                return .init()
            }
            return skeletonCell
        }

        guard let realDataCell = tableView.dequeueReusableCell(
            withIdentifier: TokenListCell.reuseID,
            for: indexPath
        ) as? TokenListCell else {
            return .init()
        }

        let coin = coins[indexPath.row]
        realDataCell.configure(with: coin, isRealData: isRealData)

        return realDataCell
    }
}
