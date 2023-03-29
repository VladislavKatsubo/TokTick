//
//  TokenListTableViewToolbar.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 22.03.23.
//

import UIKit

final class TokenListTableViewToolbar: TView {
    private enum Constants {
        static let labelHeight: CGFloat = 20.0
        static let labelWidth: CGFloat = 70.0

        static let font: UIFont = .systemFont(ofSize: labelHeight, weight: .semibold)

        static let leadingOffset: CGFloat = 20.0
        static let trailingInset: CGFloat = 20.0

        static let sortButtonImage: UIImage? = UIImage(systemName: "arrow.up.arrow.down")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }

    private let label = UILabel()
    private let skeletonLabelView = SkeletonView()
    private let sortButton = TButton()

    var onTap: (() -> Void)?

    // MARK: - Public methods
    override func didLoad() {
        setupItems()
    }

    // MARK: - Configure
    func configure(with text: String) {
        fadeAnimation(viewsToHide: [self], viewsToShow: [self]) {
            self.label.text = text
            self.skeletonLabelView.stopShimmering()
            self.skeletonLabelView.isHidden = true
            self.sortButton.isHidden = false
        }
    }

    func mockfigure() {
        self.skeletonLabelView.addShimmering()
        self.sortButton.isHidden = true
    }
}

private extension TokenListTableViewToolbar {
    // MARK: - Private methods
    func setupItems() {
        setupLabel()
        setupSkeletonLabelView()
        setupSortButton()
    }

    func setupLabel() {
        addSubview(label)
        label.font = Constants.font
        label.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.leadingOffset)
        }
    }

    func setupSkeletonLabelView() {
        addSubview(skeletonLabelView)
        skeletonLabelView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.leadingOffset)
            make.height.equalTo(Constants.labelHeight)
            make.width.equalTo(Constants.labelWidth)
        }
    }

    func setupSortButton() {
        addSubview(sortButton)
        sortButton.onTap = { [weak self] in
            self?.onTap?()
        }
        sortButton.setImage(Constants.sortButtonImage, for: .normal)
        sortButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constants.trailingInset)
        }
    }
}
