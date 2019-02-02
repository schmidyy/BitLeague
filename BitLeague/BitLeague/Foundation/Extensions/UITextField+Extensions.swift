//
//  File.swift
//  Plan
//
//  Created by Ozzie Kirkby on 2019-01-09.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

extension UITextField{
    @IBInspectable var placeholderColor: UIColor? {
        get {
            return self.placeholderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(
                string: self.placeholder != nil ? self.placeholder! : "",
                attributes: [NSAttributedString.Key.foregroundColor: newValue!]
            )
        }
    }
}
