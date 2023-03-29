//
//  AdditionalInfoCellBorderDecorationItem.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 27.03.23.
//

import UIKit

final class AdditionalInfoCellBorderDecorationItem: UICollectionReusableView {
    static let reuseIdentifier = "AdditionalInfoCellBorderDecorationItem"

    private enum Constants {
        static let borderWidth: CGFloat = 2.0
        static let blackBorderColor: UIColor = UIColor.black
        static let cornerRadius: CGFloat = 25.0
        static let backgroundColor: UIColor = UIColor.white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        drawTopLeftRightBorder(for: rect)
    }
}

private extension AdditionalInfoCellBorderDecorationItem {
    // MARK: - Private methods
    func setupView() {
        backgroundColor = Constants.backgroundColor
        clipsToBounds = true
    }

    func drawTopLeftRightBorder(for rect: CGRect) {
        let borderWidth: CGFloat = Constants.borderWidth
        let blackBorderColor = Constants.blackBorderColor
        let cornerRadius: CGFloat = Constants.cornerRadius

        let path = UIBezierPath()

        // Draw border with curved corners
        path.move(to: CGPoint(x: 0 + borderWidth / 2, y: 0))
        path.addLine(to: CGPoint(x: 0 + borderWidth / 2, y: rect.height - cornerRadius))
        path.addQuadCurve(
            to: CGPoint(
                x: cornerRadius,
                y: rect.height - borderWidth / 2
            ),
            controlPoint: CGPoint(
                x: 0 + borderWidth / 2,
                y: rect.height - borderWidth / 2
            )
        )
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: rect.height - borderWidth / 2))
        path.addQuadCurve(
            to: CGPoint(
                x: rect.width - borderWidth / 2,
                y: rect.height - cornerRadius
            ),
            controlPoint: CGPoint(
                x: rect.width - borderWidth / 2,
                y: rect.height - borderWidth / 2
            )
        )
        path.addLine(to: CGPoint(x: rect.width  - borderWidth / 2, y: 0))

        blackBorderColor.setStroke()
        path.lineWidth = borderWidth
        path.stroke()

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}

