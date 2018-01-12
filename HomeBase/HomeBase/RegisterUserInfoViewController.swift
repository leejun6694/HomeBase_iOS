//
//  RegisterUserInfoViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 7..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class RegisterUserInfoViewController: UIViewController {

    // MARK: Properties
    
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
    
    private var keyboardHeight: CGFloat = 0.0
    private let correctColor = UIColor(red: 0.0,
                                       green: 180.0/255.0,
                                       blue: 223.0/255.0,
                                       alpha: 1.0)
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "정보 입력"
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
    
    private lazy var donebutton: UIButton = {
        let donebutton = UIButton(type: .system)
        donebutton.setTitle("완료", for: .normal)
        donebutton.setTitleColor(.white, for: .normal)
        donebutton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.0)
        donebutton.backgroundColor = UIColor(red: 75.0/255.0,
                                             green: 75.0/255.0,
                                             blue: 75.0/255.0,
                                             alpha: 1.0)
        donebutton.translatesAutoresizingMaskIntoConstraints = false
        
        return donebutton
    }()
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentsView: UIView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet { nameTextField.delegate = self }
    }
    @IBOutlet weak var nameTextFieldBorder: UIView!
    private lazy var nameConditionImageView: UIImageView = {
        let nameConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        nameConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameConditionImageView
    }()
    
    @IBOutlet private weak var birthLabel: UILabel!
    @IBOutlet private weak var birthTextField: UITextField! {
        didSet { birthTextField.delegate = self }
    }
    @IBOutlet weak var birthTextFieldBorder: UIView!
    private lazy var birthConditionImageView: UIImageView = {
        let birthConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        birthConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return birthConditionImageView
    }()
    
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var heightTextField: UITextField! {
        didSet { heightTextField.delegate = self }
    }
    @IBOutlet weak var heightTextFieldBorder: UIView!
    private lazy var heightConditionImageView: UIImageView = {
        let heightConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        heightConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return heightConditionImageView
    }()
    
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var weightTextField: UITextField! {
        didSet { weightTextField.delegate = self }
    }
    @IBOutlet weak var weightTextFieldBorder: UIView!
    private lazy var weightConditionImageView: UIImageView = {
        let weightConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        weightConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return weightConditionImageView
    }()
    
    // MARK: Methods
    
    @IBAction private func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        for subview in contentsView.subviews {
            if subview.isFirstResponder {
                subview.resignFirstResponder()
                break
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        donebutton.removeFromSuperview()
        accessoryView.addSubview(donebutton)
        accessoryView.addConstraints(donebuttonKeyboardConstraints())
        
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        donebutton.removeFromSuperview()
        self.view.addSubview(donebutton)
        self.view.addConstraints(donebuttonConstraints())
        
        scrollView.contentInset.bottom = 0
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationItem.titleView = titleLabel
//        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "path3")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "path3")
        
        scrollView.contentSize = contentsView.frame.size
        
        self.view.addSubview(donebutton)
        self.view.addConstraints(donebuttonConstraints())
        buttonDisabled(donebutton)
        
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

extension RegisterUserInfoViewController: UITextFieldDelegate {
    
    // MARK: Custom Methods
    
    private func textFieldConditionChecked() {
        if nameCondition, birthCondition, heightCondition, weightCondition {
            buttonEnabled(donebutton)
        } else {
            buttonDisabled(donebutton)
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
        
        if birthText.count != 12 {
            return false
        } else {
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
    
    private func bodyChecked(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        
        if text.count == 0 { return false }
        else { return true }
    }
    
    private func heightTextFieldCondition(_ state: Bool) {
        if state {
            heightCondition = true
            height = Int(heightTextField.text ?? "0") ?? 0
            heightLabel.textColor = correctColor
            heightTextField.textColor = correctColor
            heightTextField.tintColor = correctColor
            heightTextFieldBorder.backgroundColor = correctColor
            
            if !heightConditionImageView.isDescendant(of: contentsView) {
                contentsView.addSubview(heightConditionImageView)
                contentsView.addConstraints(heightConditionImageViewConstraints())
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
            weight = Int(weightTextField.text ?? "0") ?? 0
            weightLabel.textColor = correctColor
            weightTextField.textColor = correctColor
            weightTextField.tintColor = correctColor
            weightTextFieldBorder.backgroundColor = correctColor
            
            if !weightConditionImageView.isDescendant(of: contentsView) {
                contentsView.addSubview(weightConditionImageView)
                contentsView.addConstraints(weightConditionImageViewConstraints())
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
            
            scrollView.contentInset.bottom = keyboardHeight + 10.0
            weightTextField.inputAccessoryView = accessoryView
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        buttonDisabled(donebutton)
        
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
                heightTextField.becomeFirstResponder()
                
                return false
            }
            
            if currentCount == 12, range.length == 1 {
                birthTextFieldCondition(false)
            } else {
                birthTextFieldCondition(birthChecked(birthTextField))
            }
            
            if replacementCount < 13 { return true }
            else { return false }
        case heightTextField:
            if currentCount == 2, string.count == 1 {
                heightTextField.text?.append(string)
                weightTextField.becomeFirstResponder()
                
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
            birthTextField.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            
            if nameTextCount < 2 { nameTextFieldCondition(false) }
            else if nameTextCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
        case birthTextField:
            birthTextFieldCondition(birthChecked(birthTextField))
        case heightTextField:
            let heightTextCount = heightTextField.text?.count ?? 0
            if heightTextCount != 0 { heightTextField.text?.append(" cm") }
            
            heightTextFieldCondition(bodyChecked(heightTextField))
        case weightTextField:
            let weightTextCount = weightTextField.text?.count ?? 0
            if weightTextCount != 0 { weightTextField.text?.append(" kg") }
            
            weightTextFieldCondition(bodyChecked(weightTextField))
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
    
    private func heightConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: heightConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: heightTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: heightConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: heightTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: heightConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: heightTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: heightConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: heightTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func weightConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: weightConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: weightTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: weightConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: weightTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: weightConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: weightTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: weightConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: weightTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func donebuttonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: donebutton, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -45.0)
        let leadingConstraint = NSLayoutConstraint(
            item: donebutton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: donebutton, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: donebutton, attribute: .bottom, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func donebuttonKeyboardConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: donebutton, attribute: .top, relatedBy: .equal,
            toItem: accessoryView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: donebutton, attribute: .leading, relatedBy: .equal,
            toItem: accessoryView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: donebutton, attribute: .trailing, relatedBy: .equal,
            toItem: accessoryView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: donebutton, attribute: .bottom, relatedBy: .equal,
            toItem: accessoryView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
}
