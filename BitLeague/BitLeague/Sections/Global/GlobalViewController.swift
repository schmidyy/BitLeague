//
//  GlobalViewController.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

class GlobalViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var avatarImageView: UIImageView!
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        DispatchQueue.main.async {
            if let avatar = Device.user()?.avatar {
                self.avatarImageView.image = UIImage.load(from: avatar)
            } else {
                self.avatarImageView.image = UIImage(named: "template_avatar")
            }
        }
        
        fetchPosts()
    }
    
    private func fetchPosts() {
        FireClient.shared.posts(sortingKey: .claps) { posts in
            guard let posts = posts else { return }
            self.update(to: posts)
        }
    }
    
    private func update(to posts: [Post]) {
        let oldStates = self.posts
        self.posts = posts
        let changes = diff(old: oldStates, new: posts)
        feedTableView.reload(changes: changes)
    }
}

extension GlobalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        cell.delegate = self
        cell.formatCell(posts[indexPath.row])
        return cell
    }
}

extension GlobalViewController: FeedCellProtocol {
    func refreshTable() {
        fetchPosts()
    }
}
