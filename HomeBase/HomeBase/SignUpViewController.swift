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
    private var year: Int = 0
    private var month: Int = 0
    private var day: Int = 0
    
    private var emailCondition = false
    private var pwCondition = false
    private var confirmPwCondition = false
    private var nameCondition = false
    private var birthCondition = false
    
    private var keyboardHeight: CGFloat = 0.0
    private let writeColor = UIColor(red: 0.0,
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
    
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet private weak var pwTextField: UITextField! {
        didSet { pwTextField.delegate = self }
    }
    @IBOutlet weak var pwTextFieldBorder: UIView!
    private lazy var pwConditionImageView: UIImageView = {
        let pwConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        pwConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return pwConditionImageView
    }()
    
    @IBOutlet weak var confirmPwLabel: UILabel!
    @IBOutlet private weak var confirmPwTextField: UITextField! {
        didSet { confirmPwTextField.delegate = self }
    }
    @IBOutlet weak var confirmPwTextFieldBorder: UIView!
    private lazy var confirmPwConditionImageView: UIImageView = {
        let confirmPwConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        confirmPwConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return confirmPwConditionImageView
    }()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField! {
        didSet { nameTextField.delegate = self }
    }
    @IBOutlet weak var nameTextFieldBorder: UIView!
    private lazy var nameConditionImageView: UIImageView = {
        let nameConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        nameConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameConditionImageView
    }()
    
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var birthTextField: UITextField! {
        didSet { birthTextField.delegate = self }
    }
    @IBOutlet weak var birthTextFieldBorder: UIView!
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
        for subview in self.contentsView.subviews {
            if subview.isFirstResponder {
                subview.resignFirstResponder()
                break
            }
        }
    }
    
    private func doneButtonDidEnabled() {
        doneButton.isEnabled = true
        doneButton.alpha = 1.0
    }
    
    private func doneButtonDidDisabled() {
        doneButton.isEnabled = false
        doneButton.alpha = 0.5
    }
    
    @objc func doneButtonDidTapped(_ sender: UIButton) {
        self.spinner.startAnimating()
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
                        self.spinner.stopAnimating()
                        print("email sign up")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                self.spinner.stopAnimating()
                print("pw != confirmPw")
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        self.doneButton.removeFromSuperview()
        
        self.accessoryView.addSubview(doneButton)
        self.accessoryView.addConstraints(doneButtonKeyboardConstraints())
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        self.doneButton.removeFromSuperview()
        
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
        doneButtonDidDisabled()
        
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
    
    private func textFieldConditionChecking() {
        if emailCondition, pwCondition, confirmPwCondition, nameCondition, birthCondition {
            doneButtonDidEnabled()
        } else {
            doneButtonDidDisabled()
        }
    }
    
    private func emailCheck(_ textField: UITextField) -> Bool {
        let emailText = textField.text ?? ""
        
        if emailText.contains("@"), emailText.contains(".") { return true }
        else { return false }
    }
    
    private func emailTextFieldCondition(_ state: Bool) {
        if state {
            emailCondition = true
            emailLabel.textColor = writeColor
            emailTextField.textColor = writeColor
            emailTextField.tintColor = writeColor
            emailTextFieldBorder.backgroundColor = writeColor
            
            if !emailConditionImageView.isDescendant(of: self.contentsView) {
                self.contentsView.addSubview(emailConditionImageView)
                self.contentsView.addConstraints(emailConditionImageViewConstraints())
            }
        } else {
            emailCondition = false
            emailLabel.textColor = UIColor.white
            emailTextField.textColor = UIColor.white
            emailTextField.tintColor = UIColor.white
            emailTextFieldBorder.backgroundColor = UIColor.white
            
            if emailConditionImageView.isDescendant(of: self.contentsView) {
                emailConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecking()
    }
    
    private func pwCheck(_ textField: UITextField) -> Bool {
        let pwText = textField.text ?? ""
        
        if pwText.count < 6 || pwText.count > 14 { return false }
        else { return true }
    }
    
    private func pwTextFieldCondition(_ state: Bool) {
        if state {
            pwCondition = true
            pwLabel.textColor = writeColor
            pwTextField.textColor = writeColor
            pwTextField.tintColor = writeColor
            pwTextFieldBorder.backgroundColor = writeColor
            
            if !pwConditionImageView.isDescendant(of: self.contentsView) {
                self.contentsView.addSubview(pwConditionImageView)
                self.contentsView.addConstraints(pwConditionImageViewConstraints())
            }
        } else {
            pwCondition = false
            pwLabel.textColor = UIColor.white
            pwTextField.textColor = UIColor.white
            pwTextField.tintColor = UIColor.white
            pwTextFieldBorder.backgroundColor = UIColor.white
            
            if pwConditionImageView.isDescendant(of: self.contentsView) {
                pwConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecking()
    }
    
    private func confirmCheck(pwTextField: UITextField, confirmPwTextField: UITextField) -> Bool {
        let pwText = pwTextField.text ?? ""
        let confirmText = confirmPwTextField.text ?? ""
        
        if pwText != confirmText { return false }
        else if confirmText.count < 6 || confirmText.count > 14 { return false }
        else { return true }
    }
    
    private func confirmPwTextFieldCondition(_ state: Bool) {
        if state {
            confirmPwCondition = true
            confirmPwLabel.textColor = writeColor
            confirmPwTextField.textColor = writeColor
            confirmPwTextField.tintColor = writeColor
            confirmPwTextFieldBorder.backgroundColor = writeColor
            
            if !confirmPwConditionImageView.isDescendant(of: self.contentsView) {
                self.contentsView.addSubview(confirmPwConditionImageView)
                self.contentsView.addConstraints(confirmPwConditionImageViewConstraints())
            }
        } else {
            confirmPwCondition = false
            confirmPwLabel.textColor = UIColor.white
            confirmPwTextField.textColor = UIColor.white
            confirmPwTextField.tintColor = UIColor.white
            confirmPwTextFieldBorder.backgroundColor = UIColor.white
            
            if confirmPwConditionImageView.isDescendant(of: self.contentsView) {
                confirmPwConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecking()
    }
    
    private func nameTextFieldCondition(_ state: Bool) {
        if state {
            nameCondition = true
            name = nameTextField.text ?? "default"
            nameLabel.textColor = writeColor
            nameTextField.textColor = writeColor
            nameTextField.tintColor = writeColor
            nameTextFieldBorder.backgroundColor = writeColor
            
            if !nameConditionImageView.isDescendant(of: self.contentsView) {
                self.contentsView.addSubview(nameConditionImageView)
                self.contentsView.addConstraints(nameConditionImageViewConstraints())
            }
        } else {
            nameCondition = false
            nameLabel.textColor = UIColor.white
            nameTextField.textColor = UIColor.white
            nameTextField.tintColor = UIColor.white
            nameTextFieldBorder.backgroundColor = UIColor.white
            
            if nameConditionImageView.isDescendant(of: self.contentsView) {
                nameConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecking()
    }
    
    private func birthCheck(_ birthTextField: UITextField) -> Bool {
        let birthText = birthTextField.text ?? ""
        
        if birthText.count != 12 {
            return false
        } else {
            let yearStart = birthText.index(birthText.startIndex, offsetBy: 0)
            let yearEnd = birthText.index(birthText.startIndex, offsetBy: 3)
            year = Int(birthText[yearStart...yearEnd]) ?? 0
            
            let monthStart = birthText.index(birthText.startIndex, offsetBy: 6)
            let monthEnd = birthText.index(birthText.startIndex, offsetBy: 7)
            month = Int(birthText[monthStart...monthEnd]) ?? 0
            
            let dayStart = birthText.index(birthText.startIndex, offsetBy: 10)
            let dayEnd = birthText.index(birthText.startIndex, offsetBy: 11)
            day = Int(birthText[dayStart...dayEnd]) ?? 0
            
            if year < 1900 || year > 2100 {
                return false
            } else {
                switch month {
                case 1, 3, 5, 7, 8, 10, 12:
                    if day > 31 { return false }
                    else { return true }
                case 4, 6, 9, 11:
                    if day > 30 { return false }
                    else { return true }
                case 2:
                    if day > 29 { return false }
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
            birthLabel.textColor = writeColor
            birthTextField.textColor = writeColor
            birthTextField.tintColor = writeColor
            birthTextFieldBorder.backgroundColor = writeColor
            
            if !birthConditionImageView.isDescendant(of: self.contentsView) {
                self.contentsView.addSubview(birthConditionImageView)
                self.contentsView.addConstraints(birthConditionImageViewConstraints())
            }
        } else {
            birthCondition = false
            birthLabel.textColor = UIColor.white
            birthTextField.textColor = UIColor.white
            birthTextField.tintColor = UIColor.white
            birthTextFieldBorder.backgroundColor = UIColor.white
            
            if birthConditionImageView.isDescendant(of: self.contentsView) {
                birthConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecking()
    }
    
    // MARK: TextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailTextField.inputAccessoryView = self.accessoryView
        case pwTextField:
            pwTextFieldCondition(pwCheck(pwTextField))
            
            pwTextField.inputAccessoryView = self.accessoryView
        case confirmPwTextField:
            let confirmChecked = confirmCheck(pwTextField: pwTextField, confirmPwTextField: confirmPwTextField)
            confirmPwTextFieldCondition(confirmChecked)
            
            confirmPwTextField.inputAccessoryView = self.accessoryView
        case nameTextField:
            scrollView.contentInset.bottom = keyboardHeight + 10.0
            
            let nameTextCount = nameTextField.text?.count ?? 0
            
            if nameTextCount < 2 { nameTextFieldCondition(false) }
            else if nameTextCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
            
            nameTextField.inputAccessoryView = self.accessoryView
        case birthTextField:
            scrollView.contentInset.bottom = keyboardHeight + 30.0
            
            birthTextFieldCondition(birthCheck(birthTextField))
            
            birthTextField.inputAccessoryView = self.accessoryView
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
            pwTextFieldCondition(pwCheck(pwTextField))
            
            if replacementCount < 15 { return true }
            else { return false }
        case confirmPwTextField:
            let confirmPwChecked = confirmCheck(pwTextField: pwTextField, confirmPwTextField: confirmPwTextField)
            confirmPwTextFieldCondition(confirmPwChecked)
            
            if replacementCount < 15 { return true }
            else { return false }
        case nameTextField:
            if currentCount < 2 { nameTextFieldCondition(false) }
            else if currentCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
            
            if replacementCount <= 13 { return true }
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
                birthTextFieldCondition(birthCheck(birthTextField))
            }
            
            if replacementCount <= 12 { return true }
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
            emailTextFieldCondition(emailCheck(emailTextField))
        case pwTextField:
            pwTextFieldCondition(pwCheck(pwTextField))
        case confirmPwTextField:
            let confirmPwChecked = confirmCheck(pwTextField: pwTextField, confirmPwTextField: confirmPwTextField)
            confirmPwTextFieldCondition(confirmPwChecked)
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            if nameTextCount < 2 || nameTextCount > 10 {
                nameTextFieldCondition(false)
            } else {
                nameTextFieldCondition(true)
            }
        case birthTextField:
            birthTextFieldCondition(birthCheck(birthTextField))
        default:
            break
        }
    }
}

extension SignUpViewController {
    private func emailConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: self.emailConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self.emailTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.emailConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self.emailTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: self.emailConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: self.emailTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: self.emailConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: self.emailTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func pwConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: self.pwConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self.pwTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.pwConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self.pwTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: self.pwConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: self.pwTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: self.pwConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: self.pwTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func confirmPwConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: self.confirmPwConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self.confirmPwTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.confirmPwConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self.confirmPwTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: self.confirmPwConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: self.confirmPwTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: self.confirmPwConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: self.confirmPwTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }

    private func nameConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: self.nameConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self.nameTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.nameConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self.nameTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: self.nameConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: self.nameTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: self.nameConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: self.nameTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func birthConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: self.birthConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self.birthTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.birthConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self.birthTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: self.birthConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: self.birthTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: self.birthConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: self.birthTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func doneButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.doneButton, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -45.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.doneButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.doneButton, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: self.doneButton, attribute: .bottom, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func doneButtonKeyboardConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.doneButton, attribute: .top, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.doneButton, attribute: .leading, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.doneButton, attribute: .trailing, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: self.doneButton, attribute: .bottom, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
}
