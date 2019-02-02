//
//  LoginViewController.swift
//  BitLeague
//
//  Created by Mat Schmid on 2019-02-01.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit
import SCSDKLoginKit

class LoginViewController: UIViewController {
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        loginButton.layer.cornerRadius = 10
        loginButton.imageView?.contentMode = .scaleAspectFit
        view.sendSubviewToBack(gradientView)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        SCSDKLoginClient.login(from: self) { success, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            SnapClient.fetchUserData({ (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let user = user else { return }
                print(user.displayName!)
                print(user.avatar!)
            })
        }
    }
}
