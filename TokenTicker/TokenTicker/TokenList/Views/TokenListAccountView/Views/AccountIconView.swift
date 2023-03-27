//
//  AccountIconView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 23.03.23.
//

import UIKit

final class AccountIconView: TView {
    private enum Constants {
        static let color: UIColor = .black
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 15.0
        static let imageViewSize: CGSize = CGSize(width: 45.0, height: 45.0)
    }

    private let imageView = UIImageView()

    // MARK: - Configure
    func configure(with image: UIImage?) {
        self.imageView.image = image
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupItems()
    }
}

private extension AccountIconView {
    func setupItems() {
        setupCircle()
        setupImageView()
    }

    func setupCircle() {
        backgroundColor = .white
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.color.cgColor
        layer.cornerRadius = Constants.cornerRadius
    }

    func setupImageView() {
        addSubview(imageView)
        imageView.contentMode = .center
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(Constants.imageViewSize.width)
            make.height.equalTo(Constants.imageViewSize.height)
        }
    }

}
