//
//  BorderDecorationView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 24.03.23.
//

import UIKit

final class StatisticsCellBorderDecorationView: UICollectionReusableView {
    static let reuseIdentifier = "StatisticsCellBorderDecorationView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
    }

    override func draw(_ rect: CGRect) {
        drawMiddleBottomBorders(for: rect)
        drawTopLeftRightBorder(for: rect)
    }
}

private extension StatisticsCellBorderDecorationView {
    // MARK: - Private methods
    func drawTopLeftRightBorder(for rect: CGRect) {
        let borderWidth: CGFloat = 1.0
        let blackBorderColor = UIColor.black
        let cornerRadius: CGFloat = 25.0

        let path = UIBezierPath()

        // Draw border with curved corners
        path.move(to: CGPoint(x: 0 + borderWidth / 2, y: rect.height))
        path.addLine(to: CGPoint(x: 0 + borderWidth / 2, y: cornerRadius + borderWidth / 2))
        path.addQuadCurve(
            to: CGPoint(
                x: cornerRadius,
                y: borderWidth / 2
            ),
            controlPoint: CGPoint(
                x: 0 + borderWidth / 2,
                y: borderWidth / 2
            )
        )
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: borderWidth / 2))
        path.addQuadCurve(
            to: CGPoint(
                x: rect.width - borderWidth / 2,
                y: cornerRadius + borderWidth / 2
            ),
            controlPoint: CGPoint(
                x: rect.width - borderWidth / 2,
                y: borderWidth / 2
            )
        )
        path.addLine(to: CGPoint(x: rect.width  - borderWidth / 2, y: rect.height))

        blackBorderColor.setStroke()
        path.lineWidth = borderWidth
        path.stroke()

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    func drawMiddleBottomBorders(for rect: CGRect) {
        let borderWidth: CGFloat = 1.0
        let grayBorderColor = UIColor.systemGray5
        let path = UIBezierPath()

        // Draw bottom border
        path.move(to: CGPoint(x: 0, y: rect.height - borderWidth / 2))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - borderWidth / 2))

        // Draw middle vertical border
        path.move(to: CGPoint(x: (rect.width / 2), y: 0))
        path.addLine(to: CGPoint(x: (rect.width / 2), y: rect.height))

        // Draw middle horizontal border
        path.move(to: CGPoint(x: 0, y: (rect.height / 2)))
        path.addLine(to: CGPoint(x: rect.width, y: (rect.height / 2)))


        grayBorderColor.setStroke()
        path.lineWidth = borderWidth
        path.stroke()
    }
}
