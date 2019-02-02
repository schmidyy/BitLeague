//
//  NSNumber+Extensions.swift
//  Plan
//
//  Created by Mat Schmid on 2018-12-29.
//  Copyright © 2018 kirkbyo. All rights reserved.
//

import Foundation

extension NSNumber {
    var asPercentage: String {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.multiplier = 1
        percentFormatter.minimumFractionDigits = 0
        percentFormatter.maximumFractionDigits = 1
        
        return percentFormatter.string(from: self) ?? ""
    }
}

extension Float {
    var asPercentage: String {
        return NSNumber(value: self).asPercentage
    }
}

extension Double {
    var asPercentage: String {
        return NSNumber(value: self).asPercentage
    }
}

extension Int {
    var asPercentage: String {
        return NSNumber(value: self).asPercentage
    }
}
