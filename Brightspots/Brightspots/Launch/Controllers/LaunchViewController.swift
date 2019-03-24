//
//  LaunchViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/10/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import Auth0
import paper_onboarding

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SessionManager.shared.patchMode = false
        self.checkToken() {
            if SessionManager.shared.isNewUser() {
                self.showLogin()
//                self.transitionToSignUp()
            } else {
                //should eventually go to login view controller
                self.transitionToLogin()
            }
            
        }
    }
    
    // MARK: - Private Auth0
    
    fileprivate func showLogin() {
        guard plistValues(bundle: Bundle.main) != nil else { return }
        SessionManager.shared.patchMode = false
        Auth0
            .webAuth()
            .scope("openid profile offline_access")
            .audience("https://brightspots.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    print("Error: \(error)")
                case .success(let credentials):
                    if(!SessionManager.shared.store(credentials: credentials)) {
                        print("Failed to store credentials")
                    } else {
                        SessionManager.shared.retrieveProfile { error in
                            DispatchQueue.main.async {
                                guard error == nil else {
                                    print("Failed to retrieve profile: \(String(describing: error))")
                                    return self.showLogin()
                                }
                                self.transitionToMain()
                            }
                        }
                    }
                }
        }
    }
    
    fileprivate func checkToken(callback: @escaping () -> Void) {
        
        SessionManager.shared.renewAuth { error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed to retrieve credentials: \(String(describing: error))")
                    return callback()
                }
                SessionManager.shared.retrieveProfile { error in
                    DispatchQueue.main.async {
                        guard error == nil else {
                            print("Failed to retrieve profile: \(String(describing: error))")
                            return callback()
                        }
                        self.transitionToMain()
                    }
                    
                }
            }
        }
    }
    
    
    // MARK: - Navigation

    private func transitionToMain() {
        self.performSegue(withIdentifier: "mainSegue", sender: self)
    }

    private func transitionToLogin() {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    private func transitionToSignUp() {
        self.performSegue(withIdentifier: "signUpSegue", sender: self)
    }
 
}
