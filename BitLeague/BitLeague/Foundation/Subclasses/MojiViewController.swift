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
    private var feedViewController: FeedViewController!
    private var globalViewController: GlobalViewController!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutControl()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        globalViewController = storyboard.instantiateViewController(withIdentifier: "global") as? GlobalViewController
        feedViewController = storyboard.instantiateViewController(withIdentifier: "feed") as? FeedViewController
        
        
        addChild(feedViewController)
        view.addSubviewForAutoLayout(feedViewController.view)
        feedViewController.view.isHidden = true
        feedViewController.view.constrainToFill(view)
        
        addChild(globalViewController)
        view.addSubviewForAutoLayout(globalViewController.view)
        globalViewController.view.constrainToFill(view)
        globalViewController.view.isHidden = true
        
        setSelectedControlView(to: .feed, forced: true)
    }
    
    func setSelectedControlView(to control: SelectedControl, forced: Bool = false) {
        guard control != selectedControl || forced == true else { return }
        switch control {
        case .feed:
            UIView.animate(withDuration: 0.5) {
                self.globalViewController.view.isHidden = true
                self.feedViewController.view.isHidden = false
            }
        case .global:
            UIView.animate(withDuration: 0.5) {
                self.globalViewController.view.isHidden = false
                self.feedViewController.view.isHidden = true
            }
        default: break
        }
        selectedControl = control
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
        if case .add = control {
            self.navigationController?.pushViewController(BitmojiSelectorViewController(), animated: true)
        } else {
            setSelectedControlView(to: control)
        }
    }
}
