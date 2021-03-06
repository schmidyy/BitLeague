//
//  FeedTableViewCell.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

protocol FeedCellProtocol: AnyObject {
    func refreshTable()
}

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var bitmojiImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var reactImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recreateCount: UILabel!
    @IBOutlet weak var clapCount: UILabel!
    private var id: String!
    private var claps: Int!
    
    func formatCell() {
        cellContainerView.layer.cornerRadius = 20
        cellContainerView.clipsToBounds = true
    }
    
    func formatCell(_ post: Post) {
        formatCell()
        id = post.id
        claps = post.claps
        nameLabel.text = post.user.displayName
        clapCount.text = "\(post.claps)"
        recreateCount.text = "\(post.bitmoji.recreations)"
        
        if tag != post.id.hashValue {
            bitmojiImageView.image = UIImage()
            avatarImageView.image = UIImage()
            reactImage.image = UIImage()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        cellContainerView.addGestureRecognizer(tap)
        
        let deleteGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        deleteGesture.numberOfTouchesRequired = 2
        deleteGesture.minimumPressDuration = 2
        cellContainerView.addGestureRecognizer(deleteGesture)
        
        DispatchQueue.global(qos: .background).async {
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

        tag = post.id.hashValue
    }
    
    @objc func longPressed() {
        FireClient.shared.delete(id)
    }
    
    @objc func doubleTapped() {
        FireClient.shared.clap(id, claps: claps) {
        }
        
        let clapView = UIView()
        clapView.backgroundColor = .clear
        let clapImage = UIImageView(image: UIImage(named: "clap_silhoute"))
        clapView.addSubviewForAutoLayout(clapImage)
        
        cellContainerView.addSubviewForAutoLayout(clapView)
        clapView.constrainToFill(cellContainerView)
        
        NSLayoutConstraint.activate([
            clapImage.widthAnchor.constraint(equalToConstant: 50),
            clapImage.heightAnchor.constraint(equalToConstant: 50),
            clapImage.centerXAnchor.constraint(equalTo: cellContainerView.centerXAnchor),
            clapImage.centerYAnchor.constraint(equalTo: cellContainerView.centerYAnchor)
        ])
        
        clapView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            clapView.transform = CGAffineTransform.identity
        }) { _ in
            sleep(1)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                clapView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { _ in
                clapView.removeFromSuperview()
            })
        }
    }
}
