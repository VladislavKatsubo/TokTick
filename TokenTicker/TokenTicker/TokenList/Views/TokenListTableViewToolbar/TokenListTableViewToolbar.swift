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
        UIView.animate(withDuration: 0.75, animations: {
            self.alpha = 0.0
        }) { _ in
            self.label.text = text
            self.skeletonLabelView.stopShimmering()
            self.skeletonLabelView.isHidden = true
            self.sortButton.isHidden = false
            UIView.animate(withDuration: 0.75) {
                self.alpha = 1.0
            }
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
        sortButton.setImage(UIImage(systemName: "arrow.up.arrow.down")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        sortButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constants.trailingInset)
        }
    }
}
