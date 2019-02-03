//
//  FeedViewController.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit
import SCSDKLoginKit

class FeedViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var avatarImage: UIImageView!
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(recogniser)
        
        fetchPosts()
    }
    
    private func fetchPosts() {
        FireClient.shared.posts(sortingKey: .date) { posts in
            guard let posts = posts else { return }
            self.posts = posts
            self.feedTableView.reloadData()
        }
    }
    
    @objc func avatarTapped() {
        let actionSheet = UIAlertController(title: Device.user()?.displayName, message: nil, preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "Sign out", style: .destructive) { _ in
            SCSDKLoginClient.unlinkAllSessions(completion: { [weak self] success in
                if success {
                    self?.dismiss(animated: true)
                }
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(signOutAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true)
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        cell.formatCell(posts[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension FeedViewController: FeedCellProtocol {
    func refreshTable() {
        fetchPosts()
    }
}
