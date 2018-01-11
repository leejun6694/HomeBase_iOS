//
//  SignUpViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 4..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignUpViewController: UIViewController {

    // MARK: Properties
    
    private let bottomBorderColor = UIColor(red: 44.0/255.0,
                                    green: 44.0/255.0,
                                    blue: 44.0/255.0,
                                    alpha: 1.0)
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var confirmPwTextField: UITextField!
    
    // MARK: Methods
    
    @IBAction func cancelButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonDidTapped(_ sender: UIButton) {
        if let email = emailTextField.text,
            let pw = pwTextField.text,
            let confirmPw = confirmPwTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: pw) {
                (user, error) in
                
                if let error = error {
                    if let errorCode = AuthErrorCode(rawValue: error._code) {
                        switch errorCode {
                        case .invalidEmail: print("invalid email")
                        case .emailAlreadyInUse: print("email already in use")
                        case .operationNotAllowed: print("not allow account")
                        case .weakPassword: print("weak password")
                        default: break
                        }
                    }
                } else {
                    if pw == confirmPw {
                        print("email sign up")
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("confirm password wrong")
                    }
                }
            }
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
