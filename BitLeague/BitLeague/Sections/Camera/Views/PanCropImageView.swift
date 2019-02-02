//
//  PanCropImageView.swift
//  BitLeague
//
//  Created by Ozzie Kirkby on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

class PanCropImage: UIView {
    private let imageHeight: CGFloat = UIScreen.main.bounds.width * 2
    
    private let imageView = UIImageView()
    private var offsetConstraint: NSLayoutConstraint?
    private lazy var gesture = {
        return PanDirectionGestureRecognizer(direction: .vertical, target: self, action: #selector(self.panStatusChanged))
    }()
    private var previousPanConstant: CGFloat = 0
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = UIColor.lightGray
        
        imageView.contentMode = .scaleAspectFit
        addSubviewForAutoLayout(imageView)
        imageView.constrainToFillHorizontally(self)
        offsetConstraint = imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        offsetConstraint?.isActive = true
        
        // Need to give imageView some sort of context on how it should scale.
        // Without this the image would have no idea how to scale it self, which is kinda sad
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
        
        addGestureRecognizer(gesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func panStatusChanged(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: imageView)
        
        switch recognizer.state {
        case .began:
            previousPanConstant = offsetConstraint?.constant ?? 0
        case .changed:
            let aspectRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
            // Everything about this makes sense except the 32, can't figure why I am off by that much
            // :(
            let maxPan = (imageHeight * aspectRatio / 2) - 32
            let newValue = previousPanConstant + translation.y
            if newValue < -maxPan {
                offsetConstraint?.constant = -maxPan
            } else if newValue > maxPan {
                offsetConstraint?.constant = maxPan
            } else {
                offsetConstraint?.constant = newValue
            }
        case .failed, .cancelled:
            offsetConstraint?.constant = previousPanConstant
        default:
            break
        }
        layoutIfNeeded()
    }
    
    func offset() -> CGFloat {
        return offsetConstraint?.constant ?? 0
    }
}
