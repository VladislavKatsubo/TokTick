//
//  TokenDetailsCollectionView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 24.03.23.
//

import UIKit

final class TokenDetailsCollectionView: TView {
    private enum Constants {
        static let leadingTrailingInset: CGFloat = 20.0

        static let statisticsSectionGroupAbsoluteHeight: CGFloat = 80.0
        static let statisticsSectionHeaderHeight: CGFloat = 60.0
        static let statisticsSectionDecorationItemTopOffset : CGFloat = 60.0

        static let additionalInfoSectionGroupAbsoluteHeight: CGFloat = 80.0

        static let currentInfoSectionHeader: String = "Last hour metrics:"
        static let statisticsSectionHeader: String = "Overall metrics:"
    }

    private var models: [CellModel] = []
    private var collectionView: TCollectionView?

    // MARK: - Configure
    func configure(with models: [CellModel]) {
        self.models = models
        self.collectionView?.reloadData()
    }

    // MARK: - Public methods
    override func didLoad() {
        setupItems()
    }
}

private extension TokenDetailsCollectionView {
    // MARK: - Private methods
    func setupItems() {
        setupCollectionView()
    }

    func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }

        layout.register(
            StatisticsCellBorderDecorationView.self,
            forDecorationViewOfKind: StatisticsCellBorderDecorationView.reuseIdentifier
        )

        layout.register(
            AdditionalInfoCellBorderDecorationItem.self,
            forDecorationViewOfKind: AdditionalInfoCellBorderDecorationItem.reuseIdentifier
        )

        collectionView = .init(collectionViewLayout: layout)

        guard let collectionView = collectionView else { return }

        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.registerCells([
            TokenDetailsCollectionViewCurrentInfoCell.self,
            TokenDetailsCollectionViewStatisticsCell.self,
            TokenDetailsCollectionViewAdditionalInfoCell.self
        ])
        collectionView.register(
            StatisticsSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StatisticsSectionHeaderView.reuseIdentifier
        )
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constants.leadingTrailingInset)
        }
    }
}

extension TokenDetailsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - CollectionView protocol methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = models[section]

        switch section {
        case .currentInfoSectionModel(let models):
            return models.count
        case .additionalCurrentInfoSectionModel(_):
            return 1
        case .statisticsSectionModels(let models):
            return models.count
        case .additionalInfoSectionModel(_):
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = models[indexPath.section]
        switch sectionType {
        case .currentInfoSectionModel(let models):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TokenDetailsCollectionViewCurrentInfoCell.reuseID,
                for: indexPath
            ) as? TokenDetailsCollectionViewCurrentInfoCell else {
                return .init()
            }
            cell.configure(with: models[indexPath.item])
            return cell
        case .additionalCurrentInfoSectionModel(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TokenDetailsCollectionViewAdditionalInfoCell.reuseID,
                for: indexPath
            ) as? TokenDetailsCollectionViewAdditionalInfoCell else {
                return .init()
            }
            cell.configure(with: model)
            return cell
        case .statisticsSectionModels(let models):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TokenDetailsCollectionViewStatisticsCell.reuseID,
                for: indexPath
            ) as? TokenDetailsCollectionViewStatisticsCell else {
                return .init()
            }
            cell.configure(with: models[indexPath.item])
            return cell
        case .additionalInfoSectionModel(let model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TokenDetailsCollectionViewAdditionalInfoCell.reuseID,
                for: indexPath
            ) as? TokenDetailsCollectionViewAdditionalInfoCell else {
                return .init()
            }
            cell.configure(with: model)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: StatisticsSectionHeaderView.reuseIdentifier,
            for: indexPath
        ) as? StatisticsSectionHeaderView else {
            return UICollectionReusableView()
        }
        let sectionType = models[indexPath.section]
        switch sectionType {
        case .currentInfoSectionModel(_):
            headerView.configure(title: Constants.currentInfoSectionHeader)
        case .statisticsSectionModels(_):
            headerView.configure(title: Constants.statisticsSectionHeader)
        default:
            break
        }
        return headerView
    }
}

private extension TokenDetailsCollectionView {
    // MARK: - Sections setup
    func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {

        switch models[sectionIndex] {
        case .currentInfoSectionModel(_):
            return self.createStatisticsSectionLayout()
        case .additionalCurrentInfoSectionModel:
            return self.createAdditionalInfoSectionLayout()
        case .statisticsSectionModels(_):
            return self.createStatisticsSectionLayout()
        case .additionalInfoSectionModel(_):
            return self.createAdditionalInfoSectionLayout()
        }
    }

    func createStatisticsSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(Constants.statisticsSectionGroupAbsoluteHeight)
            ),
            subitem: item,
            count: 2
        )

        let section = NSCollectionLayoutSection(group: group)

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(Constants.statisticsSectionHeaderHeight)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let decoration = NSCollectionLayoutDecorationItem.background(
            elementKind: StatisticsCellBorderDecorationView.reuseIdentifier
        )

        decoration.contentInsets = .init(
            top: Constants.statisticsSectionDecorationItemTopOffset,
            leading: .zero,
            bottom: .zero,
            trailing: .zero
        )

        section.decorationItems = [decoration]
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    func createAdditionalInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem.init(layoutSize: .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(Constants.additionalInfoSectionGroupAbsoluteHeight)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        let borderDecorationItem = NSCollectionLayoutDecorationItem.background(elementKind: AdditionalInfoCellBorderDecorationItem.reuseIdentifier)
        section.decorationItems = [borderDecorationItem]
        return section
    }
}
