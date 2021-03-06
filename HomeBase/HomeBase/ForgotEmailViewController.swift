//
//  ForgotEmailViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 15..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import Alamofire

class ForgotEmailViewController: UIViewController {

    // MARK: Properties
    
    private var currentOriginY: CGFloat = 0.0
    
    private var name: String = ""
    private var year: String = ""
    private var month: String = ""
    private var day: String = ""
    
    private var nameCondition = false
    private var birthCondition = false
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "이메일 찾기"
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
    
    @IBOutlet private weak var birthLabel: UILabel!
    @IBOutlet private weak var birthTextField: UITextField!
    @IBOutlet private weak var birthTextFieldBorder: UIView!
    private lazy var birthConditionImageView: UIImageView = {
        let birthConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        birthConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return birthConditionImageView
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
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction private func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func doneButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        
        let findEmailURL = CloudFunction.methodURL(method: Method.findEmail)
        let birth: String = "\(year).\(month).\(day)"
        let parameterDictionary = ["name": name, "birth": birth]
        
        Alamofire.request(
            findEmailURL,
            method: .post,
            parameters: parameterDictionary).responseJSON {
                (response) -> Void in
                
                if response.result.isSuccess {
                    guard let value = response.result.value as? [String: [String]]
                        else { return }
                    
                    if let emails = value["emails"] {
                        guard let findEmailViewController = self.storyboard?.instantiateViewController(
                            withIdentifier: "FindEmailViewController")
                            as? FindEmailViewController else { return }
                            
                        findEmailViewController.name = self.name
                        findEmailViewController.emails = emails
                        
                        self.spinnerStopAnimating(self.spinner)
                        self.navigationController?.pushViewController(
                            findEmailViewController,
                            animated: true)
                    }
                } else {
                    guard let forgotErrorViewController = self.storyboard?.instantiateViewController(
                        withIdentifier: "ForgotErrorViewController")
                        as? ForgotErrorViewController else { return }
                        
                    forgotErrorViewController.modalPresentationStyle = .overCurrentContext
                    self.spinnerStopAnimating(self.spinner)
                    self.present(
                        forgotErrorViewController,
                        animated: false,
                        completion: nil)
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
            let keyboardHeight = keyboardRectangle.height + accessoryView.frame.size.height
            
            self.view.frame.origin.y = currentOriginY
            
            if nameTextField.isFirstResponder {
                let bottomLocationOfNextView = bottomLocationOf(birthTextFieldBorder)
                if bottomLocationOfNextView < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOfNextView
                            - keyboardHeight)
                }
            } else if birthTextField.isFirstResponder {
                if bottomLocationOf(birthTextFieldBorder) < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOf(birthTextFieldBorder)
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
            navigationController.navigationBar.barTintColor = HBColor.lightGray
        }
        self.navigationItem.titleView = titleLabel
        
        self.view.addSubview(doneButton)
        doneButtonConstraints()
        buttonDisabled(doneButton)
        
        nameTextField.delegate = self
        birthTextField.delegate = self
        
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

extension ForgotEmailViewController: UITextFieldDelegate {
    
    // MARK: Custom Methods
    
    private func textFieldConditionChecked() {
        if nameCondition, birthCondition {
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
            birthLabel.textColor = HBColor.correct
            birthTextField.textColor = HBColor.correct
            birthTextField.tintColor = HBColor.correct
            birthTextFieldBorder.backgroundColor = HBColor.correct
            
            if !birthConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(birthConditionImageView)
                self.view.addConstraints(birthConditionImageViewConstraints())
            }
        } else {
            birthCondition = false
            birthLabel.textColor = .white
            birthTextField.textColor = .white
            birthTextField.tintColor = .white
            birthTextFieldBorder.backgroundColor = .white
            
            if birthConditionImageView.isDescendant(of: self.view) {
                birthConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    // MARK: TextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            
            if nameTextCount < 2 { nameTextFieldCondition(false) }
            else if nameTextCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
            
            nameTextField.inputAccessoryView = accessoryView
        case birthTextField:
            birthTextFieldCondition(birthChecked(birthTextField))
            
            birthTextField.inputAccessoryView = accessoryView
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

extension ForgotEmailViewController {
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
            toItem: birthConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
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
