//
//  UIStackView+Extensions.swift
//  Plan
//
//  Created by Ozzie Kirkby on 2018-09-08.
//  Copyright © 2018 kirkbyo. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    convenience init(distribution: UIStackView.Distribution = .fill, axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 0) {
        self.init()
        self.distribution = distribution
        self.axis = axis
        self.spacing = spacing
    }
}
