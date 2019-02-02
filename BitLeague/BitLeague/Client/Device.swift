//
//  Device.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import Foundation

enum Device {
    private static let kUserId = "kUserId"
    private static let kUserName = "kUserName"
    private static let kUserAvatar = "kUserAvatar"
    private static let defaults = UserDefaults.standard
    
    static func setUser(_ user: User) {
        defaults.set(user.externalId, forKey: kUserId)
        defaults.set(user.displayName, forKey: kUserName)
        defaults.set(user.avatar, forKey: kUserAvatar)
    }
    
    static func user() -> User? {
        if let id = defaults.string(forKey: kUserId),
            let name = defaults.string(forKey: kUserName),
            let avatar = defaults.string(forKey: kUserAvatar) {
            return User(id: id, name: name, avatar: avatar)
        }
        return nil
    }
}
