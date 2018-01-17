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
    
    private var name: String = ""
    private var year: String = ""
    private var month: String = ""
    private var day: String = ""
    
    private var emailCondition = false
    private var pwCondition = false
    private var confirmPwCondition = false
    private var nameCondition = false
    private var birthCondition = false
    
    private var keyboardHeight: CGFloat = 0.0
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
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var contentsView: UIView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
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
    
    @IBOutlet private weak var pwLabel: UILabel!
    @IBOutlet private weak var pwTextField: UITextField! {
        didSet { pwTextField.delegate = self }
    }
    @IBOutlet private weak var pwTextFieldBorder: UIView!
    private lazy var pwConditionImageView: UIImageView = {
        let pwConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        pwConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return pwConditionImageView
    }()
    
    @IBOutlet private weak var confirmPwLabel: UILabel!
    @IBOutlet private weak var confirmPwTextField: UITextField! {
        didSet { confirmPwTextField.delegate = self }
    }
    @IBOutlet private weak var confirmPwTextFieldBorder: UIView!
    private lazy var confirmPwConditionImageView: UIImageView = {
        let confirmPwConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        confirmPwConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return confirmPwConditionImageView
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
    
    @IBOutlet private weak var birthLabel: UILabel!
    @IBOutlet private weak var birthTextField: UITextField! {
        didSet { birthTextField.delegate = self }
    }
    @IBOutlet private weak var birthTextFieldBorder: UIView!
    private lazy var birthConditionImageView: UIImageView = {
        let birthConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        birthConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return birthConditionImageView
    }()
    
    // MARK: Methods
    
    @IBAction private func cancelButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        for subview in contentsView.subviews {
            if subview.isFirstResponder {
                subview.resignFirstResponder()
                break
            }
        }
    }
    
    private func emailInfoSaved(_ user: User, email: String) {
        let ref = Database.database().reference()
        ref.child("users").child(user.uid).setValue(
            ["email": email,
             "name": name,
             "birth": "\(year).\(month).\(day)",
             "provider": "password"])
        
        print("email sign up")
    }
    
    @objc func doneButtonDidTapped(_ sender: UIButton) {
        spinner.startAnimating()
        
        if let email = emailTextField.text,
            let pw = pwTextField.text,
            let confirmPw = confirmPwTextField.text {
            
            if pw == confirmPw {
                Auth.auth().createUser(withEmail: email, password: pw) {
                    (user, error) in
                    
                    if let error = error {
                        self.spinner.stopAnimating()
                        
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
                        if let user = user {
                            Auth.auth().currentUser?.sendEmailVerification() {
                                (error) in
                                
                                if let verifyError = error {
                                    print("verification error: \(verifyError)")
                                } else {
                                    self.emailInfoSaved(user, email: email)
                                    self.spinner.stopAnimating()
                                    
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }
                        } else {
                            print("no user")
                        }
                    }
                }
            } else {
                self.spinner.stopAnimating()
                print("pw != confirmPw")
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        doneButton.removeFromSuperview()
        accessoryView.addSubview(doneButton)
        accessoryView.addConstraints(doneButtonKeyboardConstraints())
        
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        doneButton.removeFromSuperview()
        self.view.addSubview(doneButton)
        self.view.addConstraints(doneButtonConstraints())
        
        scrollView.contentInset.bottom = 0
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = contentsView.frame.size
        
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
}

extension SignUpViewController: UITextFieldDelegate {
    
    // MARK: Custom Methods
    
    private func textFieldConditionChecked() {
        if emailCondition, pwCondition, confirmPwCondition, nameCondition, birthCondition {
            buttonEnabled(doneButton)
        } else {
            buttonDisabled(doneButton)
        }
    }
    
    private func emailChecked(_ textField: UITextField) -> Bool {
        let emailText = textField.text ?? ""
        
        if emailText.contains("@"), emailText.contains(".") { return true }
        else { return false }
    }
    
    private func emailTextFieldCondition(_ state: Bool) {
        if state {
            emailCondition = true
            emailLabel.textColor = correctColor
            emailTextField.textColor = correctColor
            emailTextField.tintColor = correctColor
            emailTextFieldBorder.backgroundColor = correctColor
            
            if !emailConditionImageView.isDescendant(of: contentsView) {
                contentsView.addSubview(emailConditionImageView)
                contentsView.addConstraints(emailConditionImageViewConstraints())
            }
        } else {
            emailCondition = false
            emailLabel.textColor = .white
            emailTextField.textColor = .white
            emailTextField.tintColor = .white
            emailTextFieldBorder.backgroundColor = .white
            
            if emailConditionImageView.isDescendant(of: contentsView) {
                emailConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    private func pwChecked(_ textField: UITextField) -> Bool {
        let pwText = textField.text ?? ""
        
        if pwText.count < 6 || pwText.count > 14 { return false }
        else { return true }
    }
    
    private func pwTextFieldCondition(_ state: Bool) {
        if state {
            pwCondition = true
            pwLabel.textColor = correctColor
            pwTextField.textColor = correctColor
            pwTextField.tintColor = correctColor
            pwTextFieldBorder.backgroundColor = correctColor
            
            if !pwConditionImageView.isDescendant(of: contentsView) {
                contentsView.addSubview(pwConditionImageView)
                contentsView.addConstraints(pwConditionImageViewConstraints())
            }
        } else {
            pwCondition = false
            pwLabel.textColor = .white
            pwTextField.textColor = .white
            pwTextField.tintColor = .white
            pwTextFieldBorder.backgroundColor = .white
            
            if pwConditionImageView.isDescendant(of: contentsView) {
                pwConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    private func confirmChecked(pwTextField: UITextField, confirmPwTextField: UITextField) -> Bool {
        let pwText = pwTextField.text ?? ""
        let confirmText = confirmPwTextField.text ?? ""
        
        if pwText != confirmText { return false }
        else if confirmText.count < 6 || confirmText.count > 14 { return false }
        else { return true }
    }
    
    private func confirmPwTextFieldCondition(_ state: Bool) {
        if state {
            confirmPwCondition = true
            confirmPwLabel.textColor = correctColor
            confirmPwTextField.textColor = correctColor
            confirmPwTextField.tintColor = correctColor
            confirmPwTextFieldBorder.backgroundColor = correctColor
            
            if !confirmPwConditionImageView.isDescendant(of: contentsView) {
                contentsView.addSubview(confirmPwConditionImageView)
                contentsView.addConstraints(confirmPwConditionImageViewConstraints())
            }
        } else {
            confirmPwCondition = false
            confirmPwLabel.textColor = .white
            confirmPwTextField.textColor = .white
            confirmPwTextField.tintColor = .white
            confirmPwTextFieldBorder.backgroundColor = .white
            
            if confirmPwConditionImageView.isDescendant(of: contentsView) {
                confirmPwConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    private func nameTextFieldCondition(_ state: Bool) {
        if state {
            nameCondition = true
            name = nameTextField.text ?? "default"
            nameLabel.textColor = correctColor
            nameTextField.textColor = correctColor
            nameTextField.tintColor = correctColor
            nameTextFieldBorder.backgroundColor = correctColor
            
            if !nameConditionImageView.isDescendant(of: contentsView) {
                contentsView.addSubview(nameConditionImageView)
                contentsView.addConstraints(nameConditionImageViewConstraints())
            }
        } else {
            nameCondition = false
            nameLabel.textColor = .white
            nameTextField.textColor = .white
            nameTextField.tintColor = .white
            nameTextFieldBorder.backgroundColor = .white
            
            if nameConditionImageView.isDescendant(of: contentsView) {
                nameConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    private func birthChecked(_ birthTextField: UITextField) -> Bool {
        let birthText = birthTextField.text ?? ""
        
        if birthText.count != 12 { return false }
        else {
            let yearStart = birthText.index(birthText.startIndex, offsetBy: 0)
            let yearEnd = birthText.index(birthText.startIndex, offsetBy: 3)
            year = String(birthText[yearStart...yearEnd])
            
            let monthStart = birthText.index(birthText.startIndex, offsetBy: 6)
            let monthEnd = birthText.index(birthText.startIndex, offsetBy: 7)
            month = String(birthText[monthStart...monthEnd])
            
            let dayStart = birthText.index(birthText.startIndex, offsetBy: 10)
            let dayEnd = birthText.index(birthText.startIndex, offsetBy: 11)
            day = String(birthText[dayStart...dayEnd])
            
            let intYear = Int(year) ?? 0
            let intMonth = Int(month) ?? 0
            let intDay = Int(day) ?? 0
            
            if intYear < 1900 || intYear > 2100 { return false }
            else {
                switch intMonth {
                case 1, 3, 5, 7, 8, 10, 12:
                    if intDay > 31 { return false }
                    else { return true }
                case 4, 6, 9, 11:
                    if intDay > 30 { return false }
                    else { return true }
                case 2:
                    if intDay > 29 { return false }
                    else { return true }
                default:
                    return false
                }
            }
        }
    }
    
    private func birthTextFieldCondition(_ state: Bool) {
        if state {
            birthCondition = true
            birthLabel.textColor = correctColor
            birthTextField.textColor = correctColor
            birthTextField.tintColor = correctColor
            birthTextFieldBorder.backgroundColor = correctColor
            
            if !birthConditionImageView.isDescendant(of: contentsView) {
                contentsView.addSubview(birthConditionImageView)
                contentsView.addConstraints(birthConditionImageViewConstraints())
            }
        } else {
            birthCondition = false
            birthLabel.textColor = .white
            birthTextField.textColor = .white
            birthTextField.tintColor = .white
            birthTextFieldBorder.backgroundColor = .white
            
            if birthConditionImageView.isDescendant(of: contentsView) {
                birthConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    // MARK: TextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailTextField.inputAccessoryView = accessoryView
        case pwTextField:
            pwTextFieldCondition(pwChecked(pwTextField))
            
            pwTextField.inputAccessoryView = accessoryView
        case confirmPwTextField:
            let confirmed = confirmChecked(pwTextField: pwTextField,
                                           confirmPwTextField: confirmPwTextField)
            confirmPwTextFieldCondition(confirmed)
            
            confirmPwTextField.inputAccessoryView = accessoryView
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            
            if nameTextCount < 2 { nameTextFieldCondition(false) }
            else if nameTextCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
            
            scrollView.contentInset.bottom = keyboardHeight + 10.0
            nameTextField.inputAccessoryView = accessoryView
        case birthTextField:
            birthTextFieldCondition(birthChecked(birthTextField))
            
            scrollView.contentInset.bottom = keyboardHeight + 30.0
            birthTextField.inputAccessoryView = accessoryView
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.count ?? 0
        let replacementCount = currentCount + string.count - range.length
        
        switch textField {
        case emailTextField:
            if replacementCount < 25 { return true }
            else { return false }
        case pwTextField:
            pwTextFieldCondition(pwChecked(pwTextField))
            
            if replacementCount < 15 { return true }
            else { return false }
        case confirmPwTextField:
            let confirmed = confirmChecked(pwTextField: pwTextField,
                                           confirmPwTextField: confirmPwTextField)
            confirmPwTextFieldCondition(confirmed)
            
            if replacementCount < 15 { return true }
            else { return false }
        case nameTextField:
            if currentCount < 2 { nameTextFieldCondition(false) }
            else if currentCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
            
            if replacementCount < 14 { return true }
            else { return false }
        case birthTextField:
            if currentCount == 4, string.count == 1 {
                birthTextField.text?.append(". ")
            } else if currentCount == 8, string.count == 1 {
                birthTextField.text?.append(". ")
            } else if currentCount == 7, range.length == 1 {
                birthTextField.text?.removeLast()
                birthTextField.text?.removeLast()
            } else if currentCount == 11, range.length == 1 {
                birthTextField.text?.removeLast()
                birthTextField.text?.removeLast()
            } else if currentCount == 11, string.count == 1 {
                birthTextField.text?.append(string)
                birthTextField.resignFirstResponder()
                
                return false
            }
            
            if currentCount == 12, range.length == 1 {
                birthTextFieldCondition(false)
            } else {
                birthTextFieldCondition(birthChecked(birthTextField))
            }
            
            if replacementCount < 13 { return true }
            else { return false }
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            pwTextField.becomeFirstResponder()
        case pwTextField:
            confirmPwTextField.becomeFirstResponder()
        case confirmPwTextField:
            nameTextField.becomeFirstResponder()
        case nameTextField:
            birthTextField.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailTextFieldCondition(emailChecked(emailTextField))
        case pwTextField:
            pwTextFieldCondition(pwChecked(pwTextField))
        case confirmPwTextField:
            let confirmed = confirmChecked(pwTextField: pwTextField,
                                           confirmPwTextField: confirmPwTextField)
            confirmPwTextFieldCondition(confirmed)
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            if nameTextCount < 2 || nameTextCount > 10 {
                nameTextFieldCondition(false)
            } else {
                nameTextFieldCondition(true)
            }
        case birthTextField:
            birthTextFieldCondition(birthChecked(birthTextField))
        default:
            break
        }
    }
}

extension SignUpViewController {
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
    
    private func pwConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: pwConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: pwTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: pwConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: pwTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pwConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: pwTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pwConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: pwTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func confirmPwConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: confirmPwConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: confirmPwTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: confirmPwConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: confirmPwTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: confirmPwConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: confirmPwTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: confirmPwConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: confirmPwTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }

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
    
    private func birthConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: birthConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: birthTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: birthConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: birthTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: birthConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: birthTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: birthConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: birthTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
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
