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
    
    // MARK: Properties
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!

    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction private func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        for subview in self.view.subviews {
            if subview.isFirstResponder {
                subview.resignFirstResponder()
                break
            }
        }
    }
    
    private func userConnected() {
        spinner.stopAnimating()
        
        if let currentUser = Auth.auth().currentUser {
            print("current user email: \(currentUser.email ?? "default")")
            
            let registerTeamNavigation =
                self.storyboard?.instantiateViewController(withIdentifier: "RegisterTeamNavigation") as? RegisterTeamNavigation
            
            UIApplication.shared.keyWindow?.rootViewController = registerTeamNavigation
        }
    }
   
    @IBAction private func emailSignInButtonDidTapped(_ sender: UIButton) {
        spinner.startAnimating()
        
        if let email = emailTextField.text, let pw = pwTextField.text {
            Auth.auth().signIn(withEmail: email, password: pw) {
                (user, error) in
                
                if let error = error {
                    self.spinner.stopAnimating()
                    
                    if let errorCode = AuthErrorCode(rawValue: error._code) {
                        switch errorCode {
                        case .userNotFound: print("no user")
                        case .operationNotAllowed: print("not allow account")
                        case .invalidEmail: print("invalid email")
                        case .userDisabled: print("disabled user")
                        case .wrongPassword: print("wrong password")
                        default: break
                        }
                    }
                } else {
                    print("email connected")
                    self.userConnected()
                }
            }
        }
    }
    
    @IBAction private func emailSignUpButtonDidTapped(_ sender: UIButton) {
        if let signUpViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as?  SignUpViewController {
            
            self.present(signUpViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction private func googleSignInButtonDidTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction private func facebookSignInButtonDidTapped(_ sender: UIButton) {
        spinner.startAnimating()
        
        let facebookLoginManager = FBSDKLoginManager()
        facebookLoginManager.logIn(withReadPermissions: ["email"], from: self) {
            (result, error) in
            
            if error != nil {
                self.spinner.stopAnimating()
                print("facebook sign in error")
            }
            if let result = result {
                if result.isCancelled {
                    print("facebook sign in cancelled")
                } else {
                    let credential = FacebookAuthProvider.credential(
                        withAccessToken: FBSDKAccessToken.current().tokenString)
                    
                    Auth.auth().signIn(with: credential) {
                        (user, error) in
                        
                        if let error = error {
                            self.spinner.stopAnimating()
                            print("facebook sign in error: \(error)")
                            return
                        } else {
                            print("facebook connected")
                            self.userConnected()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: Google Delegate
extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        spinner.startAnimating()
        
        if let error = error {
            spinner.stopAnimating()
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
                self.spinner.stopAnimating()
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
