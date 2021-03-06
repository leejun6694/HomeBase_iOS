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
    
    private var currentOriginY: CGFloat = 0.0
    
    private var name: String = ""
    private var email: String = ""
    
    private var nameCondition = false
    private var emailCondition = false
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "비밀번호 찾기"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nameTextFieldBorder: UIView!
    private lazy var nameConditionImageView: UIImageView = {
        let nameConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        nameConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameConditionImageView
    }()
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var emailTextFieldBorder: UIView!
    private lazy var emailConditionImageView: UIImageView = {
        let emailConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        emailConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return emailConditionImageView
    }()
    
    private lazy var accessoryView: UIView = {
        let accessoryViewFrame = CGRect(
            x: 0.0,
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
        doneButton.titleLabel?.font = UIFont(
            name: "AppleSDGothicNeo-Bold",
            size: 18.0)
        doneButton.addTarget(
            self,
            action: #selector(doneButtonDidTapped(_:)),
            for: .touchUpInside)
        doneButton.backgroundColor = HBColor.darkGray
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        return doneButton
    }()
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
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
                        guard let forgotErrorViewController =
                            self.storyboard?.instantiateViewController(
                                withIdentifier: "ForgotErrorViewController")
                                as? ForgotErrorViewController else { return }
                            
                        forgotErrorViewController.modalPresentationStyle = .overCurrentContext
                        self.spinnerStopAnimating(self.spinner)
                        self.present(
                            forgotErrorViewController,
                            animated: false,
                            completion: nil)
                    } else {
                        Auth.auth().sendPasswordReset(withEmail: self.email) {
                            (error) in
                            
                            if let error = error {
                                print(error.localizedDescription)
                            }
                        }

                        guard let findPasswordViewController =
                            self.storyboard?.instantiateViewController(
                                withIdentifier: "FindPasswordViewController")
                                as? FindPasswordViewController else { return }
                            
                        findPasswordViewController.name = self.name
                        findPasswordViewController.email = self.email
                            
                        self.spinnerStopAnimating(self.spinner)
                        self.navigationController?.pushViewController(
                            findPasswordViewController,
                            animated: true)
                    }
                } else {
                    self.spinnerStopAnimating(self.spinner)
                }
        }
    }
    
    @IBAction private func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        doneButton.removeFromSuperview()
        accessoryView.addSubview(doneButton)
        accessoryView.addConstraints(doneButtonKeyboardConstraints())
        
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height + accessoryView.frame.size.height
            
            self.view.frame.origin.y = currentOriginY
            
            if nameTextField.isFirstResponder {
                let bottomLocationOfNextView = bottomLocationOf(emailTextFieldBorder)
                if bottomLocationOfNextView < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOfNextView
                            - keyboardHeight)
                }
            } else if emailTextField.isFirstResponder {
                if bottomLocationOf(emailTextFieldBorder) < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOf(emailTextFieldBorder)
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
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.barTintColor = HBColor.gray
        }
        self.navigationItem.titleView = titleLabel
        
        self.view.addSubview(doneButton)
        doneButtonConstraints()
        buttonDisabled(doneButton)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        
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
            nameLabel.textColor = HBColor.correct
            nameTextField.textColor = HBColor.correct
            nameTextField.tintColor = HBColor.correct
            nameTextFieldBorder.backgroundColor = HBColor.correct
            
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
            emailLabel.textColor = HBColor.correct
            emailTextField.textColor = HBColor.correct
            emailTextField.tintColor = HBColor.correct
            emailTextFieldBorder.backgroundColor = HBColor.correct
            
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
            
            if replacementCount < 31 { return true }
            else { return false }
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            nameTextField.resignFirstResponder()
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
        let leadingConstraint = NSLayoutConstraint(
            item: nameConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: nameTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: nameTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: nameConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func emailConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: emailTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: emailTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: emailTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: emailConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
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
