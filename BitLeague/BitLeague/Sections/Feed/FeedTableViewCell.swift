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
    @IBOutlet weak var bitmojiImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var reactImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recreateCount: UILabel!
    @IBOutlet weak var clapCount: UILabel!
    
    func formatCell() {
        cellContainerView.layer.cornerRadius = 20
        cellContainerView.clipsToBounds = true
    }
    
    func formatCell(_ post: Post) {
        formatCell()
        nameLabel.text = post.user.displayName
        clapCount.text = "\(post.claps)"
        recreateCount.text = "\(post.bitmoji.recreations)"
        
        self.bitmojiImageView.image = UIImage()
        self.avatarImageView.image = UIImage()
        self.reactImage.image = UIImage()
        DispatchQueue.global(priority: .background).async {
            guard let bitmojiImage = UIImage.load(from: post.bitmoji.image),
                let avatarImage = UIImage.load(from: post.user.avatar!),
                let reactionImage = UIImage.load(from: post.image)
            else { return }
            
            DispatchQueue.main.async {
                self.bitmojiImageView.image = bitmojiImage
                self.avatarImageView.image = avatarImage
                self.reactImage.image = reactionImage
            }
        }
    }
}
