//
//  UIViewController+Extensions.swift
//  Plan
//
//  Created by Mat Schmid on 2019-01-03.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Presents a ViewController as a modal from the top or bottom
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present
    ///   - size: Frame of the modal
    ///   - direction: .up for bottom-up, .down for top-down
    ///   - allowsBackgroundTapDismissal: Modal is dismissed when tapping the dimmed view if true
    func presentModally(_ viewController: UIViewController, size: CGSize, direction: PresentationDirection = .up, allowsBackgroundTapDismissal: Bool = false) {
        let transitionDelegate = ModalPresentationManager(direction: direction, size: size, allowsBackgroundTapDismissal: allowsBackgroundTapDismissal)
        viewController.transitioningDelegate = transitionDelegate
        viewController.modalPresentationStyle = .custom
        viewController.view.clipsToBounds = true
        viewController.view.layer.cornerRadius = 20
        present(viewController, animated: true)
    }
}

