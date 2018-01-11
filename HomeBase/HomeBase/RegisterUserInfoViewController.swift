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
    private var year: Int = 0
    private var month: Int = 0
    private var day: Int = 0
    private var height: Int = 0
    private var weight: Int = 0
    
    private var nameCondition = false
    private var birthCondition = false
    private var heightCondition = false
    private var weightCondition = false
    
    private var keyboardHeight: CGFloat = 0.0
    private let writeColor = UIColor(red: 0.0,
                                      green: 180.0/255.0,
                                      blue: 223.0/255.0,
                                      alpha: 1.0)
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "정보 입력"
        titleLabel.textColor = UIColor.white
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
    
    private func leftPaddingAdded(_ textField: UITextField) {
        let leftPadding:CGFloat = self.view.frame.size.width * 9 / 414
        let viewHeight:CGFloat = self.view.frame.size.height * 35 / 707
        let leftPaddingView = UIView(frame: CGRect(x: 0.0,
                                                   y: 0.0,
                                                   width: leftPadding,
                                                   height: viewHeight))
        
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
    }
    
    private func donebuttonDidEnabled() {
        donebutton.isEnabled = true
        donebutton.alpha = 1.0
    }
    
    private func donebuttonDidDisabled() {
        donebutton.isEnabled = false
        donebutton.alpha = 0.5
    }
    
    @IBAction private func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        for subview in self.contentsView.subviews {
            if subview.isFirstResponder {
                subview.resignFirstResponder()
                break
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        self.donebutton.removeFromSuperview()
        
        self.accessoryView.addSubview(donebutton)
        self.accessoryView.addConstraints(donebuttonKeyboardConstraints())
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        self.donebutton.removeFromSuperview()
        
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
        leftPaddingAdded(nameTextField)
        leftPaddingAdded(birthTextField)
        leftPaddingAdded(heightTextField)
        leftPaddingAdded(weightTextField)
        
        self.view.addSubview(donebutton)
        self.view.addConstraints(donebuttonConstraints())
        donebuttonDidDisabled()
        
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
    
    private func textFieldConditionChecking() {
        if nameCondition, birthCondition, heightCondition, weightCondition {
            donebuttonDidEnabled()
        } else {
            donebuttonDidDisabled()
        }
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
    
    private func bodyCheck(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        
        if text.count == 0 { return false }
        else { return true }
    }
    
    private func heightTextFieldCondition(_ state: Bool) {
        if state {
            heightCondition = true
            height = Int(heightTextField.text ?? "0") ?? 0
            heightLabel.textColor = writeColor
            heightTextField.textColor = writeColor
            heightTextField.tintColor = writeColor
            heightTextFieldBorder.backgroundColor = writeColor
            
            if !heightConditionImageView.isDescendant(of: self.contentsView) {
                self.contentsView.addSubview(heightConditionImageView)
                self.contentsView.addConstraints(heightConditionImageViewConstraints())
            }
        } else {
            heightCondition = false
            heightLabel.textColor = UIColor.white
            heightTextField.textColor = UIColor.white
            heightTextField.tintColor = UIColor.white
            heightTextFieldBorder.backgroundColor = UIColor.white
            
            if heightConditionImageView.isDescendant(of: self.contentsView) {
                heightConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecking()
    }
    
    private func weightTextFieldCondition(_ state: Bool) {
        if state {
            weightCondition = true
            weight = Int(weightTextField.text ?? "0") ?? 0
            weightLabel.textColor = writeColor
            weightTextField.textColor = writeColor
            weightTextField.tintColor = writeColor
            weightTextFieldBorder.backgroundColor = writeColor
            
            if !weightConditionImageView.isDescendant(of: self.contentsView) {
                self.contentsView.addSubview(weightConditionImageView)
                self.contentsView.addConstraints(weightConditionImageViewConstraints())
            }
        } else {
            weightCondition = false
            weightLabel.textColor = UIColor.white
            weightTextField.textColor = UIColor.white
            weightTextField.tintColor = UIColor.white
            weightTextFieldBorder.backgroundColor = UIColor.white
            
            if weightConditionImageView.isDescendant(of: self.contentsView) {
                weightConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecking()
    }
    
    // MARK: TextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            
            if nameTextCount < 2 { nameTextFieldCondition(false) }
            else if nameTextCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
            
            nameTextField.inputAccessoryView = self.accessoryView
        case birthTextField:
            birthTextFieldCondition(birthCheck(birthTextField))
            
            birthTextField.inputAccessoryView = self.accessoryView
        case heightTextField:
            let heightText = heightTextField.text ?? ""
            if heightText.contains("cm") {
                heightTextField.text?.removeLast()
                heightTextField.text?.removeLast()
                heightTextField.text?.removeLast()
            }
            
            heightTextFieldCondition(bodyCheck(heightTextField))
            
            heightTextField.inputAccessoryView = self.accessoryView
        case weightTextField:
            scrollView.contentInset.bottom = keyboardHeight + 10.0
            
            let weightText = weightTextField.text ?? ""
            if weightText.contains("kg") {
                weightTextField.text?.removeLast()
                weightTextField.text?.removeLast()
                weightTextField.text?.removeLast()
            }
            
            weightTextFieldCondition(bodyCheck(weightTextField))
            
            weightTextField.inputAccessoryView = self.accessoryView
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        donebuttonDidDisabled()
        
        let currentCount = textField.text?.count ?? 0
        let replacementCount = currentCount + string.count - range.length
        
        switch textField {
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
                heightTextField.becomeFirstResponder()
                
                return false
            }
            
            if currentCount == 12, range.length == 1 {
                birthTextFieldCondition(false)
            } else {
                birthTextFieldCondition(birthCheck(birthTextField))
            }
            
            if replacementCount <= 12 { return true }
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
                heightTextFieldCondition(bodyCheck(heightTextField))
            } else {
                heightTextFieldCondition(false)
            }
            
            if replacementCount <= 3 { return true }
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
                weightTextFieldCondition(bodyCheck(weightTextField))
            } else {
                weightTextFieldCondition(false)
            }
            
            if replacementCount <= 3 { return true }
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
            
            if nameTextCount < 2 || nameTextCount > 10 { nameTextFieldCondition(false) }
            else { nameTextFieldCondition(true) }
        case birthTextField:
            let birthChecked = birthCheck(birthTextField)
            birthTextFieldCondition(birthChecked)
        case heightTextField:
            let heightTextCount = heightTextField.text?.count ?? 0
            if heightTextCount != 0 { heightTextField.text?.append(" cm") }
            
            let heightChecked = bodyCheck(heightTextField)
            heightTextFieldCondition(heightChecked)
        case weightTextField:
            let weightTextCount = weightTextField.text?.count ?? 0
            if weightTextCount != 0 { weightTextField.text?.append(" kg") }
            
            let weightChecked = bodyCheck(weightTextField)
            weightTextFieldCondition(weightChecked)
        default:
            break
        }
    }
}

extension RegisterUserInfoViewController {
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
    
    private func heightConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: self.heightConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self.heightTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.heightConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self.heightTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: self.heightConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: self.heightTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: self.heightConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: self.heightTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func weightConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: self.weightConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self.weightTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.weightConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self.weightTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: self.weightConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: self.weightTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: self.weightConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: self.weightTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func donebuttonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.donebutton, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -45.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.donebutton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.donebutton, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: self.donebutton, attribute: .bottom, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func donebuttonKeyboardConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.donebutton, attribute: .top, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.donebutton, attribute: .leading, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.donebutton, attribute: .trailing, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: self.donebutton, attribute: .bottom, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
}
