//
//  TokenDetailsCollectionView+Model.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 25.03.23.
//

import Foundation

extension TokenDetailsCollectionView {
    enum CellModel {
        case currentInfoSectionModel([TokenDetailsCollectionViewCurrentInfoCell.Model])
        case additionalCurrentInfoSectionModel(TokenDetailsCollectionViewAdditionalInfoCell.Model)
        case statisticsSectionModels([TokenDetailsCollectionViewStatisticsCell.Model])
        case additionalInfoSectionModel(TokenDetailsCollectionViewAdditionalInfoCell.Model)
    }
}
