//
//  TTextField.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 7.03.23.
//

import UIKit

final class TTextField: UITextField {

    // MARK: - Constants
    private enum Constants {
        static let borderColor: UIColor = .black
        static let borderWidth: CGFloat = 1.0
        static let cornerRadius: CGFloat = 10.0

        static let mainTextColor: UIColor = .black
        static let textAlignment = NSTextAlignment.left
        static let font: UIFont = .systemFont(ofSize: 18.0, weight: .light)
        static let placeholderColor: UIColor = .systemGray

        static let standardTextPadding: UIEdgeInsets = .init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        static let rightViewTextPadding: UIEdgeInsets = .init(top: 10.0, left: 10.0, bottom: 10.0, right: 50.0)
    }

    override var placeholder: String? {
        didSet {
            let attributedString: NSAttributedString = .init(
                string: placeholder ?? "",
                attributes: [
                    .foregroundColor: Constants.placeholderColor,
                    .font: Constants.font
                ]
            )
            attributedPlaceholder = attributedString
        }
    }


    // MARK: - Init
    init() {
        super.init(frame: .zero)
        didLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure
    func configure(with text: String, placeholder: String) {
        self.text = text
        self.placeholder = placeholder
    }

    // MARK: - Public methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        let textPadding = rightView == nil ? Constants.standardTextPadding : Constants.rightViewTextPadding
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        let textPadding = rightView == nil ? Constants.standardTextPadding : Constants.rightViewTextPadding
        return rect.inset(by: textPadding)
    }

    func didLoad() {
        setup()
    }
}

private extension TTextField {
    // MARK: - Private methods
    func setup() {
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = Constants.borderColor.cgColor

        tintColor = .black
        textAlignment = Constants.textAlignment
        textColor = Constants.mainTextColor
        backgroundColor = .clear

        addTarget(self, action: #selector(didValueChanged), for: .editingChanged)
    }

    @objc
    func didValueChanged() {
        print(text ?? "no text")
    }
}
