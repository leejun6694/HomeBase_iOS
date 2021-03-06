//
//  RegisterUserInfoViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 7..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterUserInfoViewController: UIViewController {

    // MARK: Properties
    
    var teamCode: String!
    
    private var currentOriginY: CGFloat = 0.0
    private var keyboardHeight: CGFloat = 0.0
    
    private var name: String = ""
    private var year: String = ""
    private var month: String = ""
    private var day: String = ""
    private var height: Int = 0
    private var weight: Int = 0
    
    private var nameCondition = false
    private var birthCondition = false
    private var heightCondition = false
    private var weightCondition = false
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "정보 입력"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    @IBOutlet private weak var contentsView: UIView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet weak var nameTextFieldBorder: UIView!
    private lazy var nameConditionImageView: UIImageView = {
        let nameConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        nameConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameConditionImageView
    }()
    
    @IBOutlet private weak var birthLabel: UILabel!
    @IBOutlet private weak var birthTextField: UITextField!
    @IBOutlet weak var birthTextFieldBorder: UIView!
    private lazy var birthConditionImageView: UIImageView = {
        let birthConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        birthConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return birthConditionImageView
    }()
    
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var heightTextField: UITextField!
    @IBOutlet weak var heightTextFieldBorder: UIView!
    private lazy var heightConditionImageView: UIImageView = {
        let heightConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        heightConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return heightConditionImageView
    }()
    
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var weightTextField: UITextField!
    @IBOutlet weak var weightTextFieldBorder: UIView!
    private lazy var weightConditionImageView: UIImageView = {
        let weightConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        weightConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return weightConditionImageView
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
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction private func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func doneButtonDidTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        guard let registerPlayerInfoViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "RegisterPlayerInfoViewController")
                as? RegisterPlayerInfoViewController else { return }
            
        registerPlayerInfoViewController.name = self.name
        registerPlayerInfoViewController.year = self.year
        registerPlayerInfoViewController.month = self.month
        registerPlayerInfoViewController.day = self.day
        registerPlayerInfoViewController.height = self.height
        registerPlayerInfoViewController.weight = self.weight
        
        registerPlayerInfoViewController.teamCode = self.teamCode
        self.navigationController?.pushViewController(
            registerPlayerInfoViewController,
            animated: true)
    }
    
    private func autoCompleteTextField() {
        spinnerStartAnimating(spinner)
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let currentUser = Auth.auth().currentUser else { return }
            let ref = Database.database().reference()
            
            ref.child("users").child(currentUser.uid).observeSingleEvent(of: .value) {
                (snapshot, error) in
                
                if let error = error {
                    print("database error: \(error)")
                } else {
                    let value = snapshot.value as? NSDictionary
                    let provider = value?["provider"] as? String ?? ""
                    
                    if provider == "password" {
                        let name = value?["name"] as? String ?? ""
                        let birth = value?["birth"] as? String ?? ""
                        
                        DispatchQueue.main.async {
                            self.nameTextField.text = name
                            self.birthTextField.text = birth
                            
                            self.nameTextFieldCondition(true)
                            self.birthTextFieldCondition(self.birthChecked(self.birthTextField))
                        }
                    }
                }
            }
        }
        spinnerStopAnimating(spinner)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        doneButton.removeFromSuperview()
        accessoryView.addSubview(doneButton)
        accessoryView.addConstraints(doneButtonKeyboardConstraints())
        
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height + accessoryView.frame.size.height
            
            for subview in contentsView.subviews {
                if subview.isFirstResponder {
                    var bottomLocationOfNextView: CGFloat = 0.0
                    switch subview {
                    case nameTextField:
                        bottomLocationOfNextView = bottomLocationOf(birthTextFieldBorder)
                    case birthTextField:
                        bottomLocationOfNextView = bottomLocationOf(heightTextFieldBorder)
                    case heightTextField:
                        bottomLocationOfNextView = bottomLocationOf(weightTextFieldBorder)
                    case weightTextField:
                        bottomLocationOfNextView = bottomLocationOf(weightTextFieldBorder)
                    default:
                        break
                    }
                    if bottomLocationOfNextView < keyboardHeight {
                        self.view.frame.origin.y += (
                            bottomLocationOfNextView
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
        doneButtonConstraints()
        
        self.view.frame.origin.y = currentOriginY
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let registerUserNavigation = self.navigationController as? RegisterUserNavigation {
            self.teamCode = registerUserNavigation.teamCode
        }
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.isTranslucent = false
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
        heightTextField.delegate = self
        weightTextField.delegate = self
        
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
        
        autoCompleteTextField()
        currentOriginY = self.view.frame.origin.y
    }
}

extension RegisterUserInfoViewController: UITextFieldDelegate {
    
    // MARK: Custom Methods
    
    private func textFieldConditionChecked() {
        if nameCondition, birthCondition, heightCondition, weightCondition {
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
            birthLabel.textColor = HBColor.correct
            birthTextField.textColor = HBColor.correct
            birthTextField.tintColor = HBColor.correct
            birthTextFieldBorder.backgroundColor = HBColor.correct
            
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
    
    private func bodyChecked(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        
        if text.count == 0 { return false }
        else { return true }
    }
    
    private func heightTextFieldCondition(_ state: Bool) {
        if state {
            heightCondition = true
            heightLabel.textColor = HBColor.correct
            heightTextField.textColor = HBColor.correct
            heightTextField.tintColor = HBColor.correct
            heightTextFieldBorder.backgroundColor = HBColor.correct
            
            if !heightConditionImageView.isDescendant(of: contentsView) {
                contentsView.addSubview(heightConditionImageView)
                contentsView.addConstraints(heightConditionImageViewConstraints())
            }
            
            var heightText = heightTextField.text ?? ""
            if heightText.count > 3 {
                heightText.removeLast()
                heightText.removeLast()
                heightText.removeLast()
                
                height = Int(heightText) ?? 0
            }
        } else {
            heightCondition = false
            heightLabel.textColor = .white
            heightTextField.textColor = .white
            heightTextField.tintColor = .white
            heightTextFieldBorder.backgroundColor = .white
            
            if heightConditionImageView.isDescendant(of: contentsView) {
                heightConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    private func weightTextFieldCondition(_ state: Bool) {
        if state {
            weightCondition = true
            weightLabel.textColor = HBColor.correct
            weightTextField.textColor = HBColor.correct
            weightTextField.tintColor = HBColor.correct
            weightTextFieldBorder.backgroundColor = HBColor.correct
            
            if !weightConditionImageView.isDescendant(of: contentsView) {
                contentsView.addSubview(weightConditionImageView)
                contentsView.addConstraints(weightConditionImageViewConstraints())
            }
            
            var weightText = weightTextField.text ?? ""
            if weightText.count > 3 {
                weightText.removeLast()
                weightText.removeLast()
                weightText.removeLast()
                
                weight = Int(weightText) ?? 0
            }
        } else {
            weightCondition = false
            weightLabel.textColor = .white
            weightTextField.textColor = .white
            weightTextField.tintColor = .white
            weightTextFieldBorder.backgroundColor = .white
            
            if weightConditionImageView.isDescendant(of: contentsView) {
                weightConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    // MARK: TextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            
            if nameTextCount < 2 || nameTextCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
            
            nameTextField.inputAccessoryView = accessoryView
        case birthTextField:
            birthTextFieldCondition(birthChecked(birthTextField))
            
            birthTextField.inputAccessoryView = accessoryView
        case heightTextField:
            let heightText = heightTextField.text ?? ""
            if heightText.contains("cm") {
                heightTextField.text?.removeLast()
                heightTextField.text?.removeLast()
                heightTextField.text?.removeLast()
            }

            heightTextFieldCondition(bodyChecked(heightTextField))
            
            heightTextField.inputAccessoryView = accessoryView
        case weightTextField:
            let weightText = weightTextField.text ?? ""
            if weightText.contains("kg") {
                weightTextField.text?.removeLast()
                weightTextField.text?.removeLast()
                weightTextField.text?.removeLast()
            }
            
            weightTextFieldCondition(bodyChecked(weightTextField))
            
            weightTextField.inputAccessoryView = accessoryView
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        buttonDisabled(doneButton)
        
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
        case heightTextField:
            if currentCount == 2, string.count == 1 {
                heightTextField.text?.append(string)
                heightTextField.resignFirstResponder()
                
                return false
            }
            
            if currentCount == 0, string.count == 1 {
                heightTextFieldCondition(true)
            } else if replacementCount > 0 {
                heightTextFieldCondition(bodyChecked(heightTextField))
            } else {
                heightTextFieldCondition(false)
            }
            
            if replacementCount < 4 { return true }
            else { return false }
        case weightTextField:
            if currentCount == 2, string.count == 1 {
                weightTextField.text?.append(string)
                weightTextField.resignFirstResponder()
                
                return false
            }
            
            if currentCount == 0, string.count == 1 {
                weightTextFieldCondition(true)
            } else if replacementCount > 0 {
                weightTextFieldCondition(bodyChecked(weightTextField))
            } else {
                weightTextFieldCondition(false)
            }
            
            if replacementCount < 4 { return true }
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
            heightTextField.becomeFirstResponder()
        case heightTextField:
            heightTextField.resignFirstResponder()
            weightTextField.becomeFirstResponder()
        case weightTextField:
            weightTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        
        switch textField {
        case nameTextField:
            if textCount < 2 { nameTextFieldCondition(false) }
            else if textCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
        case birthTextField:
            birthTextFieldCondition(birthChecked(birthTextField))
            
            heightTextField.becomeFirstResponder()
        case heightTextField:
            if textCount != 0 { heightTextField.text?.append(" cm") }
            
            heightTextFieldCondition(bodyChecked(heightTextField))
            
            weightTextField.becomeFirstResponder()
        case weightTextField:
            if textCount != 0 { weightTextField.text?.append(" kg") }
            
            weightTextFieldCondition(bodyChecked(weightTextField))
            
            weightTextField.resignFirstResponder()
        default:
            break
        }
    }
}

extension RegisterUserInfoViewController {
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
    
    private func heightConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: heightConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: heightTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: heightConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: heightTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: heightConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: heightTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: heightConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: heightConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func weightConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: weightConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: weightTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: weightConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: weightTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: weightConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: weightTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: weightConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: weightConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
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
