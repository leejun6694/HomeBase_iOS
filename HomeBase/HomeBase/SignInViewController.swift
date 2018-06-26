//
//  SignInViewController.swift
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

class SignInViewController: UIViewController {
    
    // MARK: Properties
    
    private var currentOriginY: CGFloat = 0.0
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!
    @IBOutlet private weak var pwTextFieldBorder: UIView!
    @IBOutlet private weak var signInButton: UIButton!
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction private func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func userConnected() {
        if let currentUser = Auth.auth().currentUser {
            CloudFunction.getUserDataWith(currentUser) {
                (user, error) -> Void in
                
                if let teamCode = user?.teamCode {
                    if teamCode != "default" {
                        CloudFunction.getPlayerDataWith(currentUser) {
                            (player, error) -> Void in
                            
                            if let playerData = player {
                                CloudFunction.getTeamDataWith(teamCode) {
                                    (teamData, error) -> Void in
                                    
                                    if let teamData = teamData {
                                        let storageRef = Storage.storage().reference()
                                        let logoRef = storageRef.child(teamData.logo)
                                        let photoRef = storageRef.child(teamData.photo)
                                        
                                        logoRef.getData(maxSize: 4 * 1024 * 1024) {
                                            (logoData, error) in
                                            
                                            photoRef.getData(maxSize: 4 * 1024 * 1024) {
                                                (photoData, error) in
                                            
                                                if let error = error {
                                                    print(error)
                                                } else {
                                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                    
                                                    guard let mainTabBarController = mainStoryboard.instantiateViewController(
                                                        withIdentifier: "MainTabBarController")
                                                        as? MainTabBarController else { return }
                                                    
                                                    mainTabBarController.playerData = playerData
                                                    mainTabBarController.teamData = teamData
                                                    mainTabBarController.teamLogo = UIImage(data: logoData!) ?? #imageLiteral(resourceName: "team_logo")
                                                    mainTabBarController.teamPhoto = UIImage(data: photoData!) ?? #imageLiteral(resourceName: "backgroundMain")
                                                    
                                                    self.spinnerStopAnimating(self.spinner)
                                                
                                                    UIApplication.shared.keyWindow?.rootViewController = mainTabBarController
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                guard let registerUserNavigation = self.storyboard?.instantiateViewController(
                                    withIdentifier: "RegisterUserNavigation")
                                    as? RegisterUserNavigation else { return }
                                    
                                registerUserNavigation.teamCode = teamCode
                                self.spinnerStopAnimating(self.spinner)
                                UIApplication.shared.keyWindow?.rootViewController = registerUserNavigation
                            }
                        }
                    } else {
                        guard let registerTeamNavigation =
                            self.storyboard?.instantiateViewController(
                                withIdentifier: "RegisterTeamNavigation")
                                as? RegisterTeamNavigation else { return }
                            
                        self.spinnerStopAnimating(self.spinner)
                        UIApplication.shared.keyWindow?.rootViewController =
                        registerTeamNavigation
                    }
                } else {
                    guard let registerTeamNavigation =
                        self.storyboard?.instantiateViewController(
                            withIdentifier: "RegisterTeamNavigation")
                            as? RegisterTeamNavigation else { return }
                        
                    self.spinnerStopAnimating(self.spinner)
                    UIApplication.shared.keyWindow?.rootViewController = registerTeamNavigation
                }
            }
        }
    }
    
    @IBAction private func emailSignInButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        signOutCurrentUser()
        
        let email = emailTextField.text ?? "no email"
        let pw = pwTextField.text ?? "no password"
        
        Auth.auth().signIn(withEmail: email, password: pw) {
            (user, error) in
            
            if let error = error {
                var errorText: String = ""
                
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    switch errorCode {
                    case .userNotFound: errorText = "존재하지 않는 사용자입니다"
                    case .operationNotAllowed: errorText = "허용되지 않은 사용자입니다"
                    case .invalidEmail: errorText = "존재하지 않는 이메일입니다"
                    case .userDisabled: errorText = "접근할 수 없는 사용자입니다"
                    case .wrongPassword: errorText = "잘못된 비밀번호입니다"
                    default: break
                    }
                }
                
                guard let signInErrorViewController =
                    self.storyboard?.instantiateViewController(
                    withIdentifier: "SignInErrorViewController")
                        as? SignInErrorViewController else { return }
                    
                signInErrorViewController.errorText = errorText
                signInErrorViewController.modalPresentationStyle = .overCurrentContext
                self.spinnerStopAnimating(self.spinner)
                self.present(signInErrorViewController, animated: false, completion: nil)
            } else {
                guard let currentUser = user else { return }
                
                if currentUser.isEmailVerified {
                    self.userConnected()
                } else {
                    let errorText: String = "이메일 인증이 되지 않은 사용자입니다"
                    
                    guard let signInErrorViewController =
                        self.storyboard?.instantiateViewController(
                        withIdentifier: "SignInErrorViewController")
                            as? SignInErrorViewController else { return }
                        
                    signInErrorViewController.errorText = errorText
                    signInErrorViewController.modalPresentationStyle = .overCurrentContext
                    self.spinnerStopAnimating(self.spinner)
                    self.present(signInErrorViewController, animated: false, completion: nil)
                }
            }
        }
    }
    
    @IBAction private func emailSignUpButtonDidTapped(_ sender: UIButton) {
        guard let signUpViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "SignUpViewController")
                as? SignUpViewController else { return }
            
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    @IBAction private func forgotButtonDidTapped(_ sender: UIButton) {
        guard let forgotSelectNavigation =
            self.storyboard?.instantiateViewController(
                withIdentifier: "ForgotSelectNavigation")
                as? ForgotSelectNavigation else { return }
            
        forgotSelectNavigation.modalPresentationStyle = .overCurrentContext
        self.present(forgotSelectNavigation, animated: false, completion: nil)
    }
    
    @IBAction private func googleSignInButtonDidTapped(_ sender: UIButton) {
        signOutCurrentUser()
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction private func facebookSignInButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        signOutCurrentUser()
        
        let facebookLoginManager = FBSDKLoginManager()
        facebookLoginManager.logIn(withReadPermissions: ["email"], from: self) {
            (result, error) in
            
            if error != nil {
                self.spinnerStopAnimating(self.spinner)
            } else {
                guard let result = result else { return }
                
                if result.isCancelled {
                    self.spinnerStopAnimating(self.spinner)
                } else {
                    let credential = FacebookAuthProvider.credential(
                        withAccessToken: FBSDKAccessToken.current().tokenString)
                    
                    Auth.auth().signIn(with: credential) {
                        (user, error) in
                        
                        if let _ = error {
                            self.spinnerStopAnimating(self.spinner)
                            return
                        } else {
                            self.userConnected()
                        }
                    }
                }
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if emailTextField.isFirstResponder {
                let bottomLocationOfNextView = bottomLocationOf(pwTextFieldBorder)
                if bottomLocationOfNextView < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOfNextView
                            - keyboardHeight)
                }
            } else if pwTextField.isFirstResponder {
                let bottomLocationOfNextView = bottomLocationOf(signInButton)
                if bottomLocationOfNextView < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOfNextView
                            - keyboardHeight)
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification:NSNotification) {
        self.view.frame.origin.y = currentOriginY
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        pwTextField.delegate = self
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        currentOriginY = self.view.frame.origin.y
    }
}

// MARK: Google Delegate
extension SignInViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        spinnerStartAnimating(self.spinner)
        
        if let _ = error {
            spinnerStopAnimating(spinner)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) {
            (user, error) in
            
            if let _ = error {
                self.spinnerStopAnimating(self.spinner)
                return
            } else {
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
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            emailTextField.resignFirstResponder()
            pwTextField.becomeFirstResponder()
        case pwTextField:
            pwTextField.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
}

