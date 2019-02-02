//
//  CaptureButtonView.swift
//  BitLeague
//
//  Created by Ozzie Kirkby on 2019-02-01.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

class CaptureButtonView: UIView {
    var tapSelector: (() -> ())?
    private let circleView = UIView()
    
    init() {
        super.init(frame: CGRect())
        
        circleView.clipsToBounds = true
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        circleView.layer.borderWidth = 3
        addSubviewForAutoLayout(circleView)
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            circleView.rightAnchor.constraint(equalTo: rightAnchor),
            circleView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        circleView.addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleView.layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        tapSelector?()
    }
}
