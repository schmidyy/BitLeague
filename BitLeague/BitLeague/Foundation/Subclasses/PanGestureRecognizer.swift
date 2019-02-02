//
//  PanGestureRecognizer.swift
//  BitLeague
//
//  Created by Ozzie Kirkby on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

/* -----
 Code borrowed from http://stackoverflow.com/a/30607392/4471750
 ----- */

import UIKit
import UIKit.UIGestureRecognizerSubclass

/**
 Directions a pan can happen
 
 - Vertical:   Pan towards up or down
 - Horizontal: Pan towards left or right
 */
enum PanDirection {
    case vertical
    case horizontal
}

/// View used to only call the delegate for a pan in a certain direction.
class PanDirectionGestureRecognizer: UIPanGestureRecognizer {
    /// Direction that a pan gesture can happen
    let direction : PanDirection
    
    init(direction: PanDirection, target: AnyObject, action: Selector) {
        self.direction = direction
        super.init(target: target, action: action)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if state == .began {
            let vel = velocity(in: self.view!)
            switch direction {
            case .horizontal where abs(vel.y) > abs(vel.x):
                state = .cancelled
            case .vertical where abs(vel.x) > abs(vel.y):
                state = .cancelled
            default:
                break
            }
        }
    }
}
