//
//  RegisterTeamJoinViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 10..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Alamofire

class RegisterTeamJoinViewController: UIViewController {
    
    // MARK: Properties
    
    private var currentOriginY:CGFloat = 0.0
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    @IBOutlet private var teamCodeTextField: UITextField!
    
    // MARK: Methods
    
    @IBAction private func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction private func backButtonDidTapped(_ sender: UIButton) {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction private func doneButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        
        let parameterDictionary = ["teamCode": teamCodeTextField.text ?? ""]
        
        Alamofire.request(
            CloudFunction.methodURL(method: Method.getTeam),
            method: .get,
            parameters: parameterDictionary).responseJSON {
                (response) -> Void in
                
                if response.result.isSuccess {
                    if let value = response.result.value as? [String: Any] {
                        if let teamLogo = value["logo"] as? String,
                            let teamName = value["name"] as? String,
                            let members = value["members"] as? [String] {
                            let teamCode = self.teamCodeTextField.text ?? "default"
                            var teamLogoImage:UIImage = UIImage()
                            
                            let storageRef = Storage.storage().reference()
                            let imageRef = storageRef.child(teamLogo)
                            
                            imageRef.getData(maxSize: 4 * 1024 * 10240) {
                                (data, error) in
                                
                                if let error = error {
                                    print(error)
                                } else {
                                    teamLogoImage = UIImage(data: data!) ?? #imageLiteral(resourceName: "team_logo")
                                    
                                    if let registerTeamJoinEnterViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterTeamJoinEnterViewController") as? RegisterTeamJoinEnterViewController {
                                        
                                        registerTeamJoinEnterViewController.teamLogoImage = teamLogoImage
                                        registerTeamJoinEnterViewController.teamCode = teamCode
                                        registerTeamJoinEnterViewController.teamName = teamName
                                        registerTeamJoinEnterViewController.members = members
                                        registerTeamJoinEnterViewController.modalPresentationStyle = .overCurrentContext
                                        self.spinnerStopAnimating(self.spinner)
                                        self.present(registerTeamJoinEnterViewController, animated: false, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if let registerTeamJoinErrorViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterTeamJoinErrorViewController") as? RegisterTeamJoinErrorViewController {
                        
                        registerTeamJoinErrorViewController.modalPresentationStyle = .overCurrentContext
                        self.spinnerStopAnimating(self.spinner)
                        self.present(registerTeamJoinErrorViewController, animated: false, completion: nil)
                    }
                }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height + 5.0
            
            self.view.frame.origin.y = currentOriginY
            
            for subview in self.view.subviews {
                if subview.isFirstResponder {
                    if bottomLocationOf(subview) < keyboardHeight {
                        self.view.frame.origin.y +=
                            (bottomLocationOf(subview) - keyboardHeight)
                    }
                    break
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
