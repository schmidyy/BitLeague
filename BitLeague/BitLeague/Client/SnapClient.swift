//
//  SnapClient.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import SCSDKLoginKit

enum SnapClient {
    static func fetchUserData(_ completion: @escaping ((User?, Error?) -> ())) {
        let query = "{ me { externalId, displayName, bitmoji { avatar }}}"
        
        SCSDKLoginClient.fetchUserData(
            withQuery: query,
            variables: nil,
            success: { userData in
                guard let userData = userData else {
                    completion(nil, nil)
                    return
                }
                if let data = try? JSONSerialization.data(withJSONObject: userData, options: .prettyPrinted),
                    let userEntity = try? JSONDecoder().decode(User.self, from: data) {
                    completion(userEntity, nil)
                }
        }) { error, isUserLoggedOut in
            completion(nil, error)
        }
    }
}
