//
//  TViewController.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 8.03.23.
//

import UIKit

class TViewController: UIViewController {

    private(set) var singleTap: UITapGestureRecognizer?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        addKeyboardObserver()
    }

    // MARK: - Public methods
    @objc
    func didTapArroundView() {
        view.endEditing(true)
    }
}

private extension TViewController {
    // MARK: - Private methods
    func setupItems() {
        view.backgroundColor = .white

        hideViewWhenTappedAround()
    }

    func hideViewWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapArroundView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        singleTap = tap
    }

    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    @objc
    func keyboardWillChangeFrame(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let animationDurationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let animationCurveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
              let keyboardFrameEndValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }

        let animationDuration = animationDurationNumber.doubleValue
        let animationCurveOptions = UIView.AnimationOptions(rawValue: animationCurveNumber.uintValue << 16)
        let keyboardFrame = keyboardFrameEndValue.cgRectValue

        guard let textField = UIResponder.currentFirst() as? UITextField,
              let window = UIApplication.shared.windows.first
        else {
            return
        }

        let keyboardFrameInView = view.convert(keyboardFrame, from: window)
        let intersection = view.bounds.intersection(keyboardFrameInView)
        let textFieldFrameInView = view.convert(textField.frame, from: textField.superview)
        let textFieldIntersection = textFieldFrameInView.intersection(keyboardFrameInView)
        let keyboardHeight = textFieldIntersection.isNull ? 0 : intersection.size.height

        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: animationCurveOptions,
            animations: { [unowned self] in
                let bottomInset = keyboardHeight > 0 ? keyboardHeight : 0
                self.view.frame.origin.y = -bottomInset
                self.view.layoutIfNeeded()
            }
        )
    }
}

extension TViewController: UIGestureRecognizerDelegate {
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigator = navigationController else { return false }

        return (navigator.viewControllers.count > 1)
    }
}
