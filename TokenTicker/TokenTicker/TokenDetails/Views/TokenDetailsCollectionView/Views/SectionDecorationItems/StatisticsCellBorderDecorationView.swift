//
//  BorderDecorationView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 24.03.23.
//

import UIKit

final class StatisticsCellBorderDecorationView: UICollectionReusableView {
    static let reuseIdentifier = "StatisticsCellBorderDecorationView"

    private enum Constants {
        static let borderWidth: CGFloat = 2.0
        static let grayBorderColor: UIColor = UIColor.systemGray5
        static let blackBorderColor: UIColor = UIColor.black
        static let cornerRadius: CGFloat = 25.0
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        drawMiddleBottomBorders(for: rect)
        drawTopLeftRightBorder(for: rect)
    }
}

private extension StatisticsCellBorderDecorationView {
    // MARK: - Private methods
    func setupView() {
        backgroundColor = UIColor.white
        clipsToBounds = true
    }

    func drawTopLeftRightBorder(for rect: CGRect) {
        let borderWidth: CGFloat = Constants.borderWidth
        let blackBorderColor = Constants.blackBorderColor
        let cornerRadius: CGFloat = Constants.cornerRadius

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
        let borderWidth: CGFloat = Constants.borderWidth
        let grayBorderColor = Constants.grayBorderColor
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
