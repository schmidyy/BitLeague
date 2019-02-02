//
//  MojiControllView.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

enum SelectedControl {
    case feed, add, global
}

protocol MojiControlProtocol {
    func controlSelected(_ control: SelectedControl)
}

class MojiControllView: UIView {
    @IBOutlet weak var wideView: UIView!
    @IBOutlet weak var addView: UIView!
    
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var globalButton: UIButton!
    
    var delegate: MojiControlProtocol?
    var selectedControl: SelectedControl!
    
    class func instanceFromNib() -> MojiControllView {
        return UINib(nibName: "MojiControllView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MojiControllView
    }
    
    func setupUI() {
        clipsToBounds = false
        wideView.layer.cornerRadius = 20
        addView.layer.cornerRadius = addView.frame.height / 2
        
        wideView.dropShadow()
        addView.dropShadow()
        
        switch selectedControl! {
        case .feed:
            feedButton.imageView?.image = UIImage(named: "feed_controll_selected")
            addButton.imageView?.image = UIImage(named: "add_controll")
            globalButton.imageView?.image = UIImage(named: "global_controll")
        case .add:
            feedButton.imageView?.image = UIImage(named: "feed_controll")
            addButton.imageView?.image = UIImage(named: "add_controll_selected")
            globalButton.imageView?.image = UIImage(named: "global_controll")
        case .global:
            feedButton.imageView?.image = UIImage(named: "feed_controll")
            addButton.imageView?.image = UIImage(named: "add_controll")
            globalButton.imageView?.image = UIImage(named: "global_controll_selected")
        }
    }
    
    
    @IBAction func feedButtonTapped(_ sender: UIButton) {
        delegate?.controlSelected(.feed)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        delegate?.controlSelected(.add)
    }
    
    @IBAction func globalButtonTapped(_ sender: Any) {
        delegate?.controlSelected(.global)
    }
}
