//
//  FeedTableViewCell.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var gradientView: GradientView!
    
    func formatCell() {
        cellContainerView.layer.cornerRadius = 20
        cellContainerView.clipsToBounds = true
    }

}
