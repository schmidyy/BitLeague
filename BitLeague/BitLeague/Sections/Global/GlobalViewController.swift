//
//  GlobalViewController.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

class GlobalViewController: MojiViewController {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var avatarImageView: UIImageView!
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.delegate = self
        feedTableView.dataSource = self
        selectedControl = .global
        
        fetchPosts()
    }
    
    private func fetchPosts() {
        FireClient.shared.posts(sortingKey: .claps) { posts in
            guard let posts = posts else { return }
            self.posts = posts
            self.feedTableView.reloadData()
        }
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
