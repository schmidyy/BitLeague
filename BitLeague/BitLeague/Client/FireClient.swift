//
//  FireClient.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import FirebaseFirestore

enum SortingKey: String {
    case date, claps
}

enum FireClient {
    static func posts(sortingKey: SortingKey, completion: @escaping(_ coins: [Post]?) -> Void) {
        let db = Firestore.firestore()
        db.collection("posts").order(by: sortingKey.rawValue, descending: true).getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            var posts: [Post] = []
            for doc in snapshot!.documents {
                // I hope no one ever looks at this code
                print("\(doc.documentID) -> \(doc.data())")
                let data = doc.data()
                let userDict = (data["user"] as! [String: Any])
                let bitmojiDict = (data["bitmoji"] as! [String: Any])
                let user = User(
                    id: userDict["id"] as! String,
                    name: userDict["displayName"] as! String,
                    avatar: userDict["avatar"] as! String
                )
                let bitmoji = Bitmoji(
                    image: bitmojiDict["image"] as! String,
                    recreations: bitmojiDict["recreations"] as! Int
                )
                let post = Post(
                    id: doc.documentID,
                    image: data["image"] as! String,
                    user: user,
                    bitmoji: bitmoji,
                    claps: data["claps"] as! Int
                )
                posts.append(post)
            }
            completion(posts)
        }
    }
}
