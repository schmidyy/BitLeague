//
//  UIView+Extensions.swift
//  Plan
//
//  Created by Ozzie Kirkby on 2018-09-08.
//  Copyright © 2018 kirkbyo. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewForAutoLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func addSubviewsForAutoLayout(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    func constrainToFill(_ view: UIView, againstLayoutMargins: Bool = false, inset: UIEdgeInsets = UIEdgeInsets()) {
        if againstLayoutMargins {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: inset.left),
                trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -inset.right),
                topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset.right),
                topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom)
            ])
        }
    }
    
    func constrainToFillVertically(_ view: UIView, againstLayoutMargins: Bool = false, inset: UIEdgeInsets = UIEdgeInsets()) {
        if againstLayoutMargins {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: inset.top),
                bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: inset.bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom)
            ])
        }
    }
    
    func constrainToFillHorizontally(_ view: UIView, againstLayoutMargins: Bool = false, inset: UIEdgeInsets = UIEdgeInsets()) {
        if againstLayoutMargins {
            NSLayoutConstraint.activate([
                leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: inset.left),
                rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: inset.right)
            ])
        } else {
            NSLayoutConstraint.activate([
                leftAnchor.constraint(equalTo: view.leftAnchor, constant: inset.left),
                rightAnchor.constraint(equalTo: view.rightAnchor, constant: inset.right)
            ])
        }
    }
}

extension UIView {
    func set(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func dropShadow(scale: Bool = true) {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
    }
}

extension NSLayoutYAxisAnchor {
    func constraint(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
}

extension NSLayoutXAxisAnchor {
    func constraint(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
}

extension NSLayoutDimension {
    func constraint(equalToConstant constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = self.constraint(equalToConstant: constant)
        constraint.priority = priority
        return constraint
    }
}
