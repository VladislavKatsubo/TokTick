//
//  TokenIconView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 14.03.23.
//

import UIKit

final class TokenIconView: TView {

    private enum Constants {
        static let color: UIColor = .black
        static let lineWidth: CGFloat = 1.0
        static let symbolSize: CGFloat = 21.0
        static let padding: CGFloat = 10.0
        static let cornerRoundingFactor: CGFloat = 0.32
    }

    private let circleLayer = CAShapeLayer()
    private let symbol = UILabel()

    // MARK: - Configure
    func configure(with tokenSymbol: String) {
        let coin = Coins(rawValue: tokenSymbol.lowercased())
        symbol.text = coin?.unicodeSymbol
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupItems()
    }
}

private extension TokenIconView {
    func setupItems() {
        setupLabel()
        setupCircle()
    }

    func setupCircle() {
        let rectWidth = bounds.width - Constants.padding * 2
        let rectHeight = bounds.height - Constants.padding * 2
        let rectX = Constants.padding
        let rectY = Constants.padding
        let cornerRadius = min(rectWidth, rectHeight) * Constants.cornerRoundingFactor
        let roundedRectanglePath = UIBezierPath(
            roundedRect: CGRect(x: rectX, y: rectY, width: rectWidth, height: rectHeight),
            byRoundingCorners: .allCorners,
            cornerRadii: .init(width: cornerRadius, height: cornerRadius)
        )
        circleLayer.path = roundedRectanglePath.cgPath
        circleLayer.lineWidth = Constants.lineWidth
        circleLayer.strokeColor = Constants.color.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor

        layer.addSublayer(circleLayer)
    }

    func setupLabel() {
        addSubview(symbol)
        symbol.font = .systemFont(ofSize: Constants.symbolSize)
        symbol.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
