//
//  Post.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import Foundation

struct Bitmoji: Hashable {
    let image: String
    let recreations: Int
}

struct Post: Hashable {
    let id: String
    let image: String
    let user: User
    let bitmoji: Bitmoji
    let claps: Int
}
