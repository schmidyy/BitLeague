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
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        loginButton.layer.cornerRadius = 10
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        SCSDKLoginClient.login(from: self) { success, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print(success ? "Success" : "Fail")
        }
    }
}
