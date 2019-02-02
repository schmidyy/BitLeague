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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.delegate = self
        feedTableView.dataSource = self
        selectedControl = .feed
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        
        let post = Post(
            id: "12345",
            image: "https://image.freepik.com/free-photo/smiling-beautiful-girl-sportswear-taking-selfie-showing-big-finger_8353-6343.jpg",
            user: User(id: "6789", name: "Kate Netties", avatar: "https://sdk.bitmoji.com/render/panel/91f228a9-f80a-49b6-aa52-e43454df9cbb-AXplUHlIrVh_dhjMAr7Nut56JzVDkg-v1.png?transparent=1&palette=1"),
            bitmoji: Post.Bitmoji.init(image: "https://infinitelyteaching.files.wordpress.com/2017/05/thumbs-up-bitmoji.png?w=354&h=356", reactions: 14),
            claps: 9
        )
        
        cell.formatCell(post)
        return cell
    }
}
