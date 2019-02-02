//
//  MojiViewController.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

class MojiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mojiControl = MojiControllView.instanceFromNib()
        mojiControl.setupUI()
        mojiControl.layer.zPosition = 999
        view.addSubviewForAutoLayout(mojiControl)
        
        NSLayoutConstraint.activate([
            mojiControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mojiControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            mojiControl.widthAnchor.constraint(equalToConstant: 228),
            mojiControl.heightAnchor.constraint(equalToConstant: 68)
        ])
    }

}
