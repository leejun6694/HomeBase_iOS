//
//  LoginViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 2..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    private struct StoryBoard {
        static let LoginToPersonalSegue = "Login To Personal"
    }
    
    // MARK: Properties
    
    @IBOutlet private weak var googleSignInButton: GIDSignInButton!
    @IBOutlet private weak var facebookSignInButton: FBSDKLoginButton!
    
    // MARK: Methods
    
    private func userConnected() {
        if let currentUser = Auth.auth().currentUser {
            print("current user email: \(currentUser.email ?? "default")")
            
            performSegue(withIdentifier: StoryBoard.LoginToPersonalSegue, sender: nil)
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        facebookSignInButton.delegate = self
    }
}

// MARK: Google Delegate
extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("google sign in error: \(error)")
            
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) {
            (user, error) in
            
            if let error = error {
                print("google sign in error: \(error)")
                return
            } else {
                print("google connected")
                self.userConnected()
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("google sign out error: \(error)")
        } else {
            print("google disconnected")
        }
    }
}

// MARK: Facebook Sign in
extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if let error = error {
            print("facebook sign in error: \(error)")
            
            return
        } else if result.isCancelled {
            print("cancelled")
        } else {
            let credential = FacebookAuthProvider.credential(
                withAccessToken: FBSDKAccessToken.current().tokenString)
            
            Auth.auth().signIn(with: credential) {
                (user, error) in
                
                if let error = error {
                    print("facebook sign in error: \(error)")
                    return
                } else {
                    print("facebook connected")
                    self.userConnected()
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("facebook disconnected")
    }
}
