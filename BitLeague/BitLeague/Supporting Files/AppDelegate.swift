//
//  AppDelegate.swift
//  BitLeague
//
//  Created by Ozzie Kirkby on 2019-02-01.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit
import SCSDKLoginKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if SCSDKLoginClient.application(app, open: url, options: options) {
            return true
        }
        return true
    }

}

