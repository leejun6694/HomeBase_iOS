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
    
    @IBOutlet private weak var facebookSignInButton: FBSDKLoginButton!
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet { self.bottomBorderWith(emailTextField) }
    }
    @IBOutlet private weak var pwTextField: UITextField! {
        didSet { self.bottomBorderWith(pwTextField) }
    }
    
    // MARK: Methods
    
    @IBAction func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
    }
    
    @IBAction private func googleSignInButtonDidTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func emailSignInButtonDidTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let pw = pwTextField.text {
            Auth.auth().signIn(withEmail: email, password: pw) {
                (user, error) in
                
                if let error = error {
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
    
    @IBAction func emailSignUpButtonDidTapped(_ sender: UIButton) {
        let signUpVC = storyboard!.instantiateViewController(withIdentifier: "SignUpViewController")
        self.present(signUpVC, animated: true, completion: nil)
    }
    
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

extension UIViewController {
    func bottomBorderWith(_ textField: UITextField) {
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.shadowColor = UIColor.darkGray.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 0.0
    }
}
