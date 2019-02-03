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
        
        fetchUserData()
    }
    
    private func setupUI() {
        loginButton.layer.cornerRadius = 10
        loginButton.imageView?.contentMode = .scaleAspectFit
        view.sendSubviewToBack(gradientView)
    }
    
    private func fetchUserData() {
        SnapClient.fetchUserData({ [weak self] (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let user = user else { return }
            print(user.displayName!)
            print(user.avatar!)
            print(user.externalId!)
            
            Device.setUser(user)
            
            DispatchQueue.main.async {
                self?.presentFeed(user)
            }
        })
    }
    
    private func presentFeed(_ user: User) {
        let navigation = UINavigationController(rootViewController: MojiViewController())
        navigation.isNavigationBarHidden = true
        navigation.hero.isEnabled = true
        present(navigation, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        SCSDKLoginClient.login(from: self) { [weak self] success, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self?.fetchUserData()
        }
    }
}
