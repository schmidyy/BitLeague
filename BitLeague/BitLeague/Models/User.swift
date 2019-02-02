//
//  User.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import Foundation

struct User {
    let displayName: String?
    let avatar: String?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    private enum DataKeys: String, CodingKey {
        case me
    }
    
    private enum MeKeys: String, CodingKey {
        case displayName
        case bitmoji
    }
    
    private enum BitmojiKeys: String, CodingKey {
        case avatar
    }
}

extension User: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        let me = try data.nestedContainer(keyedBy: MeKeys.self, forKey: .me)
        
        displayName = try? me.decode(String.self, forKey: .displayName)
        
        let bitmoji = try me.nestedContainer(keyedBy: BitmojiKeys.self, forKey: .bitmoji)
        avatar = try? bitmoji.decode(String.self, forKey: .avatar)
    }
}
