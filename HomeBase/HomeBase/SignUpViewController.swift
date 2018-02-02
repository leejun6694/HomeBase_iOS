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
    
    private var currentOriginY:CGFloat = 0.0
    
    private var name: String = ""
    private var year: String = ""
    private var month: String = ""
    private var day: String = ""
    
    private var emailCondition = false
    private var pwCondition = false
    private var confirmPwCondition = false
    private var nameCondition = false
    private var birthCondition = false
    
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
    
    
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var contentsView: UIView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
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
    private lazy var emailConditionLabel: UILabel = {
        let emailConditionLabel = UILabel()
        emailConditionLabel.text = "이메일 형식에 맞춰 입력해주세요"
        emailConditionLabel.textColor = .red
        emailConditionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.0)
        emailConditionLabel.textAlignment = .left
        emailConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return emailConditionLabel
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
    private lazy var pwConditionLabel: UILabel = {
        let pwConditionLabel = UILabel()
        pwConditionLabel.text = "비밀번호는 6-14자 입니다"
        pwConditionLabel.textColor = .red
        pwConditionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.0)
        pwConditionLabel.textAlignment = .left
        pwConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pwConditionLabel
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
    private lazy var confirmPwConditionLabel: UILabel = {
        let confirmPwConditionLabel = UILabel()
        confirmPwConditionLabel.text = "비밀번호와 일치하지 않습니다"
        confirmPwConditionLabel.textColor = .red
        confirmPwConditionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.0)
        confirmPwConditionLabel.textAlignment = .left
        confirmPwConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return confirmPwConditionLabel
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
    private lazy var nameConditionLabel: UILabel = {
        let nameConditionLabel = UILabel()
        nameConditionLabel.text = "이름은 2-10자 입니다"
        nameConditionLabel.textColor = .red
        nameConditionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.0)
        nameConditionLabel.textAlignment = .left
        nameConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameConditionLabel
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
    private lazy var birthConditionLabel: UILabel = {
        let birthConditionLabel = UILabel()
        birthConditionLabel.text = "생년월일 형식에 맞춰 입력해주세요"
        birthConditionLabel.textColor = .red
        birthConditionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.0)
        birthConditionLabel.textAlignment = .left
        birthConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return birthConditionLabel
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
        var provider:String = ""
        for profile in user.providerData {
            provider = profile.providerID
        }
        let hasTeam:Bool = false
        
        let ref = Database.database().reference()
        ref.child("users").child(user.uid).setValue(
            ["email": email,
             "name": name,
             "birth": "\(year).\(month).\(day)",
             "provider": provider,
             "hasTeam": hasTeam])
    }
    
    @objc func doneButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        self.view.endEditing(true)
        
        if let email = emailTextField.text,
            let pw = pwTextField.text,
            let confirmPw = confirmPwTextField.text {
            
            if pw == confirmPw {
                Auth.auth().createUser(withEmail: email, password: pw) {
                    (user, error) in
                    
                    if let error = error {
                        self.spinnerStopAnimating(self.spinner)
                        
                        if let errorCode = AuthErrorCode(rawValue: error._code) {
                            switch errorCode {
                            case .invalidEmail:
                                self.emailConditionLabel.text = "유효하지 않은 이메일 형식입니다"
                            case .emailAlreadyInUse:
                                self.emailConditionLabel.text = "이메일이 이미 존재합니다"
                            case .operationNotAllowed:
                                self.emailConditionLabel.text = "인증되지 않은 방법입니다"
                            case .weakPassword: print("weak password")
                            default: break
                            }
                            
                            self.emailTextField.becomeFirstResponder()
                            self.emailLabel.textColor = .white
                            self.emailTextField.textColor = .white
                            self.emailTextField.tintColor = .white
                            self.emailTextFieldBorder.backgroundColor = .red
                            if self.emailConditionImageView.isDescendant(of: self.contentsView) {
                                self.emailConditionImageView.removeFromSuperview()
                            }
                            self.contentsView.addSubview(self.emailConditionLabel)
                            self.contentsView.addConstraints(self.emailConditionLabelConstraints())
                        }
                    } else {
                        if let user = user {
                            Auth.auth().currentUser?.sendEmailVerification() {
                                (error) in
                                
                                if let verifyError = error {
                                    print("verification error: \(verifyError)")
                                } else {
                                    self.emailInfoSaved(user, email: email)
                                    self.spinnerStopAnimating(self.spinner)
                                    
                                    if let signUpCompleteViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCompleteViewController") as? SignUpCompleteViewController {
                                    
                                        self.present(signUpCompleteViewController, animated: true, completion: nil)
                                    }
                                }
                            }
                        } else {
                            print("no user")
                        }
                    }
                }
            } else {
                self.spinnerStopAnimating(spinner)
                print("pw != confirmPw")
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        doneButton.removeFromSuperview()
        accessoryView.addSubview(doneButton)
        accessoryView.addConstraints(doneButtonKeyboardConstraints())
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height + accessoryView.frame.size.height
            
            self.view.frame.origin.y = currentOriginY
            
            for subview in contentsView.subviews {
                if subview.isFirstResponder {
                    if bottomLocationOf(subview) < keyboardHeight {
                        self.view.frame.origin.y +=
                            (bottomLocationOf(subview)
                                - titleView.frame.size.height
                                - keyboardHeight)
                    }
                    break
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification:NSNotification) {
        doneButton.removeFromSuperview()
        self.view.addSubview(doneButton)
        self.view.addConstraints(doneButtonConstraints())
        
        self.view.frame.origin.y = currentOriginY
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        currentOriginY = self.view.frame.origin.y
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
        
        if birthText.count != 10 { return false }
        else {
            let yearStart = birthText.index(birthText.startIndex, offsetBy: 0)
            let yearEnd = birthText.index(birthText.startIndex, offsetBy: 3)
            year = String(birthText[yearStart...yearEnd])
            
            let monthStart = birthText.index(birthText.startIndex, offsetBy: 5)
            let monthEnd = birthText.index(birthText.startIndex, offsetBy: 6)
            month = String(birthText[monthStart...monthEnd])
            
            let dayStart = birthText.index(birthText.startIndex, offsetBy: 8)
            let dayEnd = birthText.index(birthText.startIndex, offsetBy: 9)
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
            if emailConditionLabel.isDescendant(of: contentsView) {
                emailTextFieldBorder.backgroundColor = .white
                emailConditionLabel.removeFromSuperview()
            }
            
            emailTextField.inputAccessoryView = accessoryView
        case pwTextField:
            if pwConditionLabel.isDescendant(of: contentsView) {
                pwTextFieldBorder.backgroundColor = .white
                pwConditionLabel.removeFromSuperview()
            }
            
            pwTextField.inputAccessoryView = accessoryView
        case confirmPwTextField:
            if confirmPwConditionLabel.isDescendant(of: contentsView) {
                confirmPwTextFieldBorder.backgroundColor = .white
                confirmPwConditionLabel.removeFromSuperview()
            }
            
            confirmPwTextField.inputAccessoryView = accessoryView
        case nameTextField:
            if nameConditionLabel.isDescendant(of: contentsView) {
                nameTextFieldBorder.backgroundColor = .white
                nameConditionLabel.removeFromSuperview()
            }
            
            nameTextField.inputAccessoryView = accessoryView
        case birthTextField:
            if birthConditionLabel.isDescendant(of: contentsView) {
                birthTextFieldBorder.backgroundColor = .white
                birthConditionLabel.removeFromSuperview()
            }
            
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
            if emailConditionLabel.isDescendant(of: contentsView) {
                emailConditionLabel.removeFromSuperview()
            }
            emailTextFieldCondition(emailChecked(emailTextField))
            
            if replacementCount < 31 { return true }
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
                birthTextField.text?.append(".")
            } else if currentCount == 7, string.count == 1 {
                birthTextField.text?.append(".")
            } else if currentCount == 6, range.length == 1 {
                birthTextField.text?.removeLast()
            } else if currentCount == 9, range.length == 1 {
                birthTextField.text?.removeLast()
            } else if currentCount == 9, string.count == 1 {
                birthTextField.text?.append(string)
                birthTextField.resignFirstResponder()
                
                return false
            }
            
            if currentCount == 10, range.length == 1 {
                birthTextFieldCondition(false)
            } else {
                birthTextFieldCondition(birthChecked(birthTextField))
            }
            
            if replacementCount < 11 { return true }
            else { return false }
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            emailTextField.resignFirstResponder()
            pwTextField.becomeFirstResponder()
        case pwTextField:
            pwTextField.resignFirstResponder()
            confirmPwTextField.becomeFirstResponder()
        case confirmPwTextField:
            confirmPwTextField.resignFirstResponder()
            nameTextField.becomeFirstResponder()
        case nameTextField:
            nameTextField.resignFirstResponder()
            birthTextField.becomeFirstResponder()
        case birthTextField:
            birthTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailTextFieldCondition(emailChecked(emailTextField))
            
            if !emailChecked(emailTextField) {
                emailTextFieldBorder.backgroundColor = .red
                emailConditionLabel.text = "이메일 형식에 맞춰 입력해주세요"
                contentsView.addSubview(emailConditionLabel)
                contentsView.addConstraints(emailConditionLabelConstraints())
            } else {
                if emailConditionLabel.isDescendant(of: contentsView) {
                    emailConditionLabel.removeFromSuperview()
                }
            }
        case pwTextField:
            pwTextFieldCondition(pwChecked(pwTextField))
            
            if !pwChecked(pwTextField) {
                pwTextFieldBorder.backgroundColor = .red
                contentsView.addSubview(pwConditionLabel)
                contentsView.addConstraints(pwConditionLabelConstraints())
            }
        case confirmPwTextField:
            let confirmed = confirmChecked(pwTextField: pwTextField,
                                           confirmPwTextField: confirmPwTextField)
            confirmPwTextFieldCondition(confirmed)
            
            if !confirmed {
                confirmPwTextFieldBorder.backgroundColor = .red
                contentsView.addSubview(confirmPwConditionLabel)
                contentsView.addConstraints(confirmPwConditionLabelConstraints())
            }
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            if nameTextCount < 2 || nameTextCount > 10 {
                nameTextFieldCondition(false)
                
                nameTextFieldBorder.backgroundColor = .red
                contentsView.addSubview(nameConditionLabel)
                contentsView.addConstraints(nameConditionLabelConstraints())
            } else {
                nameTextFieldCondition(true)
            }
        case birthTextField:
            birthTextFieldCondition(birthChecked(birthTextField))
            
            if !birthChecked(birthTextField) {
                birthTextFieldBorder.backgroundColor = .red
                contentsView.addSubview(birthConditionLabel)
                contentsView.addConstraints(birthConditionLabelConstraints())
            }
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
        let leadingConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: emailTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: emailTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: emailConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: emailTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func emailConditionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: emailConditionLabel, attribute: .top, relatedBy: .equal,
            toItem: emailTextFieldBorder, attribute: .bottom, multiplier: 1.0, constant: 2.0)
        let leadingConstraint = NSLayoutConstraint(
            item: emailConditionLabel, attribute: .leading, relatedBy: .equal,
            toItem: emailTextField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint]
    }
    
    private func pwConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: pwConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: pwTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: pwConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: pwTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: pwConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: pwTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pwConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: pwTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func pwConditionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: pwConditionLabel, attribute: .top, relatedBy: .equal,
            toItem: pwTextFieldBorder, attribute: .bottom, multiplier: 1.0, constant: 2.0)
        let leadingConstraint = NSLayoutConstraint(
            item: pwConditionLabel, attribute: .leading, relatedBy: .equal,
            toItem: pwTextField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint]
    }
    
    private func confirmPwConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: confirmPwConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: confirmPwTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: confirmPwConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: confirmPwTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: confirmPwConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: confirmPwTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: confirmPwConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: confirmPwTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func confirmPwConditionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: confirmPwConditionLabel, attribute: .top, relatedBy: .equal,
            toItem: confirmPwTextFieldBorder, attribute: .bottom, multiplier: 1.0, constant: 2.0)
        let leadingConstraint = NSLayoutConstraint(
            item: confirmPwConditionLabel, attribute: .leading, relatedBy: .equal,
            toItem: confirmPwTextField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint]
    }

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
            toItem: nameTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func nameConditionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: nameConditionLabel, attribute: .top, relatedBy: .equal,
            toItem: nameTextFieldBorder, attribute: .bottom, multiplier: 1.0, constant: 2.0)
        let leadingConstraint = NSLayoutConstraint(
            item: nameConditionLabel, attribute: .leading, relatedBy: .equal,
            toItem: nameTextField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint]
    }
    
    private func birthConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: birthConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: birthTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: birthConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: birthTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: birthConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: birthTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: birthConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: birthTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func birthConditionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: birthConditionLabel, attribute: .top, relatedBy: .equal,
            toItem: birthTextFieldBorder, attribute: .bottom, multiplier: 1.0, constant: 2.0)
        let leadingConstraint = NSLayoutConstraint(
            item: birthConditionLabel, attribute: .leading, relatedBy: .equal,
            toItem: birthTextField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint]
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
