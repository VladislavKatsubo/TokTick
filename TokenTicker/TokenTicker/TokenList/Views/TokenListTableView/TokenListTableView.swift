//
//  TokenListTableView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 9.03.23.
//

import UIKit

final class TokenListTableView: TView {

    private enum Constants {
        static let skeletonCellsCount: Int = 8
        static let skeletonCellHeight: CGFloat = 90.0
    }

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var tokens: [Asset] = [] {
        didSet {
            isRealData = true
        }
    }

    private var isRealData: Bool = false

    var onTap: ((Asset) -> Void)?

    // MARK: - Configure
    func configure(with tokens: [Asset]) {
        self.tokens = tokens
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
        var updatedTokens = tokens
        newIndexMapping.forEach { oldIndexPath, newIndexPath in
            updatedTokens[newIndexPath.row] = tokens[oldIndexPath.row]
        }
        self.tokens = updatedTokens
        
        self.tableView.beginUpdates()
        newIndexMapping.forEach { oldIndexPath, newIndexPath in
            self.tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        }
        self.tableView.endUpdates()
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
        tableView.showsVerticalScrollIndicator = false
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
        onTap?(tokens[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let reuseIdentifier = isRealData ? TokenListCell.reuseID : TokenListSkeletonCell.reuseID
        if reuseIdentifier == TokenListSkeletonCell.reuseID {
            return Constants.skeletonCellHeight
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension TokenListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isRealData ? tokens.count : Constants.skeletonCellsCount
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

        let token = tokens[indexPath.row]
        realDataCell.configure(with: token, isRealData: isRealData)

        return realDataCell
    }
}
