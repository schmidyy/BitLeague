//
//  FeedViewController.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit

class FeedViewController: MojiViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var feedTableView: UITableView!
    var user: User!
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.delegate = self
        feedTableView.dataSource = self
        selectedControl = .feed
        
        FireClient.posts { posts in
            guard let posts = posts else { return }
            self.posts = posts
            self.feedTableView.reloadData()
        }
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
        return cell
    }
}
