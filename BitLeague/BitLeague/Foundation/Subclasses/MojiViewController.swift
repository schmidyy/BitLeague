//
//  MojiViewController.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

class MojiViewController: UIViewController {
    
    var selectedControl: SelectedControl = .feed {
        didSet {
            layoutControl()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutControl()
    }
    
    private func layoutControl() {
        let mojiControl = MojiControllView.instanceFromNib()
        mojiControl.delegate = self
        mojiControl.selectedControl = selectedControl
        mojiControl.setupUI()
        mojiControl.layer.zPosition = 999
        view.addSubviewForAutoLayout(mojiControl)
        
        NSLayoutConstraint.activate([
            mojiControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mojiControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
            mojiControl.widthAnchor.constraint(equalToConstant: 228),
            mojiControl.heightAnchor.constraint(equalToConstant: 68)
        ])
    }
}

extension MojiViewController: MojiControlProtocol {
    func controlSelected(_ control: SelectedControl) {
        guard control != selectedControl else { return }
        selectedControl = control
        switch control {
        case .feed:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let feedViewController = storyboard.instantiateViewController(withIdentifier: "feed") as! FeedViewController
            present(feedViewController, animated: true)
        case .add:
            present(BitmojiSelectorViewController(), animated: true)
        default:
            break
        }
    }
}
