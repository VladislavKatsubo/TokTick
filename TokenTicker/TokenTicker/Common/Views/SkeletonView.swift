//
//  SkeletonView.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 21.03.23.
//

import UIKit

final class SkeletonView: TView {

    private enum Constants {
        static let cornerRadius: CGFloat = 5.0
        static let borderColor: CGColor = UIColor.systemGray4.cgColor
        static let borderWidth: CGFloat = 1.0
    }

    override func didLoad() {
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = Constants.borderColor
        layer.borderWidth = Constants.borderWidth
        clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addShimmering()
    }

    // MARK: - Shimmering Effect
    func addShimmering() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemGray6.cgColor, UIColor.systemGray5.cgColor, UIColor.systemGray6.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
        gradientLayer.name = "shimmeringGradient"

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity

        gradientLayer.add(animation, forKey: "shimmeringAnimation")

        layer.addSublayer(gradientLayer)
    }

    func stopShimmering() {
        if let shimmeringLayer = layer.sublayers?.first(where: { layer in
            layer.name == "shimmeringGradient"
        }) {
            shimmeringLayer.removeAllAnimations()
            shimmeringLayer.removeFromSuperlayer()
        }
    }
}
