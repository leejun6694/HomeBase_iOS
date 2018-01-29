//
//  ForgotPasswordViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 15..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import Alamofire

class ForgotPasswordViewController: UIViewController {

    // MARK: Properties
    
    private var name: String = ""
    private var email: String = ""
    
    private var nameCondition = false
    private var emailCondition = false
    
    private let correctColor = UIColor(red: 0.0,
                                       green: 180.0/255.0,
                                       blue: 233.0/255.0,
                                       alpha: 1.0)
    
    private lazy var accessoryView: UIView = {
        let accessoryViewFrame = CGRect(x: 0.0,
                                        y: 0.0,
                                        width: self.view.frame.width,
                                        height: 45.0)
        let accessoryView = UIView(frame: accessoryViewFrame)
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        
        return accessoryView
    }()
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
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
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "비밀번호 찾기"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet { nameTextField.delegate = self }
    }
    @IBOutlet private weak var nameTextFieldBorder: UIView!
    private lazy var nameConditionImageView: UIImageView = {
        let nameConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        nameConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameConditionImageView
    }()
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet { emailTextField.delegate = self }
    }
    @IBOutlet private weak var emailTextFieldBorder: UIView!
    private lazy var emailConditionImageView: UIImageView = {
        let emailConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        emailConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return emailConditionImageView
    }()
    
    // MARK: Methods
    
    @objc private func doneButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        
        let findPasswordURL = CloudFunction.methodURL(method: Method.findPassword)
        let parameterDictionary = ["name": name, "email": email]
        
        Alamofire.request(
            findPasswordURL,
            method: .post,
            parameters: parameterDictionary).responseString {
                (response) -> Void in
                
                if response.result.isSuccess {
                    if response.result.value == "User is not found" {
                        if let forgotErrorViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotErrorViewController") as? ForgotErrorViewController {
                            
                            forgotErrorViewController.modalPresentationStyle = .overCurrentContext
                            self.spinnerStopAnimating(self.spinner)
                            self.present(forgotErrorViewController, animated: false, completion: nil)
                        }
                    } else {
                        Auth.auth().sendPasswordReset(withEmail: self.email) {
                            (error) in
                            
                            if let error = error {
                                print(error.localizedDescription)
                            }
                        }

                        if let findPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "FindPasswordViewController") as? FindPasswordViewController {
                            
                            findPasswordViewController.name = self.name
                            findPasswordViewController.email = self.email
                            
                            self.spinnerStopAnimating(self.spinner)
                            self.navigationController?.pushViewController(findPasswordViewController, animated: true)
                        }
                    }
                } else {
                    self.spinnerStopAnimating(self.spinner)
                    print("fail")
                }
        }
    }
    
    @IBAction private func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        for subview in self.view.subviews {
            if subview.isFirstResponder {
                subview.resignFirstResponder()
                break
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        doneButton.removeFromSuperview()
        accessoryView.addSubview(doneButton)
        accessoryView.addConstraints(doneButtonKeyboardConstraints())
        
        self.view.frame.origin.y -= 100.0
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        doneButton.removeFromSuperview()
        self.view.addSubview(doneButton)
        self.view.addConstraints(doneButtonConstraints())
        
        self.view.frame.origin.y += 100.0
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 54.0/255.0, green: 54.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        self.navigationItem.titleView = titleLabel
        
        self.view.addSubview(doneButton)
        self.view.addConstraints(doneButtonConstraints())
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
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    // MARK: Custom Methods
    
    private func textFieldConditionChecked() {
        if nameCondition, emailCondition {
            buttonEnabled(doneButton)
        } else {
            buttonDisabled(doneButton)
        }
    }
    
    private func nameTextFieldCondition(_ state: Bool) {
        if state {
            nameCondition = true
            name = nameTextField.text ?? "default"
            nameLabel.textColor = correctColor
            nameTextField.textColor = correctColor
            nameTextField.tintColor = correctColor
            nameTextFieldBorder.backgroundColor = correctColor
            
            if !nameConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(nameConditionImageView)
                self.view.addConstraints(nameConditionImageViewConstraints())
            }
        } else {
            nameCondition = false
            nameLabel.textColor = .white
            nameTextField.textColor = .white
            nameTextField.tintColor = .white
            nameTextFieldBorder.backgroundColor = .white
            
            if nameConditionImageView.isDescendant(of: self.view) {
                nameConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    private func emailChecked(_ textField: UITextField) -> Bool {
        let emailText = textField.text ?? ""
        
        if emailText.contains("@"), emailText.contains(".") { return true }
        else { return false }
    }
    
    private func emailTextFieldCondition(_ state: Bool) {
        if state {
            email = emailTextField.text ?? ""
            emailCondition = true
            emailLabel.textColor = correctColor
            emailTextField.textColor = correctColor
            emailTextField.tintColor = correctColor
            emailTextFieldBorder.backgroundColor = correctColor
            
            if !emailConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(emailConditionImageView)
                self.view.addConstraints(emailConditionImageViewConstraints())
            }
        } else {
            emailCondition = false
            emailLabel.textColor = .white
            emailTextField.textColor = .white
            emailTextField.tintColor = .white
            emailTextFieldBorder.backgroundColor = .white
            
            if emailConditionImageView.isDescendant(of: self.view) {
                emailConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            
            if nameTextCount < 2 { nameTextFieldCondition(false) }
            else if nameTextCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
            
            nameTextField.inputAccessoryView = accessoryView
        case emailTextField:
            emailTextFieldCondition(emailChecked(emailTextField))
            
            emailTextField.inputAccessoryView = accessoryView
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.count ?? 0
        let replacementCount = currentCount + string.count - range.length
        
        switch textField {
        case nameTextField:
            if currentCount < 2 { nameTextFieldCondition(false) }
            else if currentCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
            
            if replacementCount < 14 { return true }
            else { return false }
        case emailTextField:
            emailTextFieldCondition(emailChecked(emailTextField))
            
            if replacementCount < 25 { return true }
            else { return false }
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            emailTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            if nameTextCount < 2 || nameTextCount > 10 {
                nameTextFieldCondition(false)
            } else {
                nameTextFieldCondition(true)
            }
        case emailTextField:
            emailTextFieldCondition(emailChecked(emailTextField))
        default:
            break
        }
    }
}

extension ForgotPasswordViewController {
    private func nameConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: nameConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: nameTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: nameConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: nameTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: nameTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: nameTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func emailConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: emailTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: emailTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: emailTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: emailTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func doneButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -45.0)
        let leadingConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .bottom, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
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
