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
import Alamofire

class LoginViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet { emailTextField.delegate = self }
    }
    @IBOutlet private weak var pwTextField: UITextField! {
        didSet { pwTextField.delegate = self }
    }

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
        if let currentUser = Auth.auth().currentUser {
            print("current user email: \(currentUser.email ?? "default")")
            
            let getPlayerURL = CloudFunction.methodURL(method: Method.getPlayer)
            let parameterDictionary = ["uid": currentUser.uid]
            
            Alamofire.request(
                getPlayerURL,
                method: .get,
                parameters: parameterDictionary).responseJSON {
                    (response) -> Void in
                
                    if response.result.isSuccess {
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        if let mainViewController = mainStoryboard.instantiateInitialViewController() as? MainViewController {
                            
                            self.spinnerStopAnimating(self.spinner)
                            UIApplication.shared.keyWindow?.rootViewController = mainViewController
                        }
                    } else {
                        if let registerTeamNavigation =
                            self.storyboard?.instantiateViewController(withIdentifier: "RegisterTeamNavigation") as? RegisterTeamNavigation {
                            
                            self.spinnerStopAnimating(self.spinner)
                            UIApplication.shared.keyWindow?.rootViewController = registerTeamNavigation
                        }
                    }
            }
        }
    }
   
    @IBAction private func emailSignInButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        
        if let email = emailTextField.text, let pw = pwTextField.text {
            Auth.auth().signIn(withEmail: email, password: pw) {
                (user, error) in
                
                if let error = error {
                    self.spinnerStopAnimating(self.spinner)
                    
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
                    if let currentUser = user {
                        if currentUser.isEmailVerified {
                            print("email connected")
                            self.userConnected()
                        } else {
                            print("email isn't verified")
                            self.spinnerStopAnimating(self.spinner)
                        }
                    }
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
    
    @IBAction private func forgotButtonDidTapped(_ sender: UIButton) {        
        if let forgotSelectNavigation =
            self.storyboard?.instantiateViewController(withIdentifier: "ForgotSelectNavigation") as? ForgotSelectNavigation {
            
            forgotSelectNavigation.modalPresentationStyle = .overCurrentContext
            self.present(forgotSelectNavigation, animated: false, completion: nil)
        }
    }
    
    @IBAction private func googleSignInButtonDidTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction private func facebookSignInButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        
        let facebookLoginManager = FBSDKLoginManager()
        facebookLoginManager.logIn(withReadPermissions: ["email"], from: self) {
            (result, error) in
            
            if error != nil {
                self.spinnerStopAnimating(self.spinner)
                print("facebook sign in error")
            }
            if let result = result {
                if result.isCancelled {
                    self.spinnerStopAnimating(self.spinner)
                    print("facebook sign in cancelled")
                } else {
                    let credential = FacebookAuthProvider.credential(
                        withAccessToken: FBSDKAccessToken.current().tokenString)
                    
                    Auth.auth().signIn(with: credential) {
                        (user, error) in
                        
                        if let error = error {
                            self.spinnerStopAnimating(self.spinner)
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
        spinnerStartAnimating(self.spinner)
        
        if let error = error {
            spinnerStopAnimating(spinner)
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
                self.spinnerStopAnimating(self.spinner)
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

// MARK: TextField Delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            pwTextField.becomeFirstResponder()
        case pwTextField:
            pwTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
}
