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
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "팀 참가"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    private lazy var accessoryView: UIView = {
        let accessoryViewFrame = CGRect(x: 0.0,
                                        y: 0.0,
                                        width: self.view.frame.width,
                                        height: 45.0)
        let accessoryView = UIView(frame: accessoryViewFrame)
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        
        return accessoryView
    }()
    
    private lazy var doneButton: UIButton = {
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("완료", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.0)
        doneButton.addTarget(self, action: #selector(doneButtonDidTapped(_:)), for: .touchUpInside)
        doneButton.backgroundColor = UIColor(red: 75.0/255.0,
                                             green: 75.0/255.0,
                                             blue: 75.0/255.0,
                                             alpha: 1.0)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        return doneButton
    }()
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    @IBOutlet private var teamCodeTextField: UITextField! {
        didSet { teamCodeTextField.delegate = self }
    }
    @IBOutlet private var teamCodeTextFieldBorder: UIView!
    
    // MARK: Methods
    
    @IBAction private func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }    
    
    @objc private func doneButtonDidTapped(_ sender: UIButton) {
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
        doneButton.removeFromSuperview()
        accessoryView.addSubview(doneButton)
        accessoryView.addConstraints(doneButtonKeyboardConstraints())
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height + 5.0
            
            self.view.frame.origin.y = currentOriginY
            
            if teamCodeTextField.isFirstResponder {
                if bottomLocationOf(teamCodeTextFieldBorder) < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOf(teamCodeTextFieldBorder)
                            - keyboardHeight)
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification:NSNotification) {
        doneButton.removeFromSuperview()
        self.view.addSubview(doneButton)
        doneButtonConstraints()
        
        self.view.frame.origin.y = currentOriginY
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.view.addSubview(doneButton)
        doneButtonConstraints()
        buttonDisabled(doneButton)
        
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
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        currentOriginY = self.view.frame.origin.y
    }
}

extension RegisterTeamJoinViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.inputAccessoryView = accessoryView
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.count ?? 0
        let replacementCount = currentCount + string.count - range.length
        
        if replacementCount > 0 {
            buttonEnabled(doneButton)
        } else {
            buttonDisabled(doneButton)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension RegisterTeamJoinViewController {
    private func doneButtonConstraints() {
        if #available(iOS 11, *) {
            let guide = self.view.safeAreaLayoutGuide
            doneButton.topAnchor.constraint(
                equalTo: guide.bottomAnchor, constant: -45.0).isActive = true
            doneButton.leadingAnchor.constraint(
                equalTo: guide.leadingAnchor, constant: 0.0).isActive = true
            doneButton.trailingAnchor.constraint(
                equalTo: guide.trailingAnchor, constant: 0.0).isActive = true
            doneButton.bottomAnchor.constraint(
                equalTo: guide.bottomAnchor, constant: 0.0).isActive = true
        } else {
            let guide = self.bottomLayoutGuide
            doneButton.topAnchor.constraint(
                equalTo: guide.bottomAnchor, constant: -45.0).isActive = true
            doneButton.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
            doneButton.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
            doneButton.bottomAnchor.constraint(
                equalTo: guide.bottomAnchor, constant: 0.0).isActive = true
        }
    }
    
    private func doneButtonKeyboardConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .top, relatedBy: .equal,
            toItem: accessoryView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .leading, relatedBy: .equal,
            toItem: accessoryView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .trailing, relatedBy: .equal,
            toItem: accessoryView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .bottom, relatedBy: .equal,
            toItem: accessoryView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
}
