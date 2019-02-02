//
//  Post.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import Foundation

struct Post {
    struct Bitmoji {
        let image: String
        let reactions: Int
    }
    
    let id: String
    let image: String
    let user: User
    let bitmoji: Bitmoji
    let claps: Int
}
