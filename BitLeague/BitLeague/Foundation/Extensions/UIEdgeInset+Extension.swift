//
//  UIEdgeInset+Extension.swift
//  Plan
//
//  Created by Ozzie Kirkby on 2018-11-12.
//  Copyright © 2018 kirkbyo. All rights reserved.
//

import UIKit

extension UIEdgeInsets: Hashable {
    init(equalInset: CGFloat) {
        self.init(top: equalInset, left: equalInset, bottom: equalInset, right: equalInset)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(left)
        hasher.combine(right)
        hasher.combine(top)
        hasher.combine(bottom)
    }
}

