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
    
    private var keyboardHeight: CGFloat = 0
    
    private lazy var accessoryView: UIView = {
        let accessoryViewFrame = CGRect(x: 0.0,
                                        y: 0.0,
                                        width: self.view.frame.width,
                                        height: 45)
        let accessoryView = UIView(frame: accessoryViewFrame)
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        
        return accessoryView
    }()
    
    private lazy var registerButton: UIButton = {
        let registerButton = UIButton(type: .system)
        registerButton.setTitle("다음", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        registerButton.backgroundColor = UIColor(red: 75.0/255.0,
                                                 green: 75.0/255.0,
                                                 blue: 75.0/255.0,
                                                 alpha: 0.8)
        registerButton.isEnabled = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        return registerButton
    }()
    
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet {
            bottomBorderWith(nameTextField)
            nameTextField.delegate = self
        }
    }
    private lazy var nameConditionLabel: UILabel = {
        let nameConditionLabel = UILabel()
        nameConditionLabel.text = "올바르지 않은 이름입니다"
        nameConditionLabel.textColor = .red
        nameConditionLabel.font = nameConditionLabel.font.withSize(15.0)
        nameConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameConditionLabel
    }()
    
    @IBOutlet private weak var birthTextField: UITextField! {
        didSet {
            bottomBorderWith(birthTextField)
            birthTextField.delegate = self
        }
    }
    private lazy var birthConditionLabel: UILabel = {
        let birthConditionLabel = UILabel()
        birthConditionLabel.text = "유효한 생년월일을 입력해주세요"
        birthConditionLabel.textColor = .red
        birthConditionLabel.font = nameConditionLabel.font.withSize(15.0)
        birthConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return birthConditionLabel
    }()
    
    @IBOutlet private weak var heightTextField: UITextField! {
        didSet {
            bottomBorderWith(heightTextField)
            heightTextField.delegate = self
        }
    }
    private lazy var heightConditionLabel: UILabel = {
        let heightConditionLabel = UILabel()
        heightConditionLabel.text = "유효한 신장을 입력해주세요"
        heightConditionLabel.textColor = .red
        heightConditionLabel.font = nameConditionLabel.font.withSize(15.0)
        heightConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return heightConditionLabel
    }()
    
    @IBOutlet private weak var weightTextField: UITextField! {
        didSet {
            bottomBorderWith(weightTextField)
            weightTextField.delegate = self
        }
    }
    private lazy var weightConditionLabel: UILabel = {
        let weightConditionLabel = UILabel()
        weightConditionLabel.text = "유효한 체중을 입력해주세요"
        weightConditionLabel.textColor = .red
        weightConditionLabel.font = nameConditionLabel.font.withSize(15.0)
        weightConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return weightConditionLabel
    }()
    
    // MARK: Methods
    
    private func registerButtonDidEnabled() {
        registerButton.isEnabled = true
        registerButton.alpha = 1.0
    }
    
    private func registerButtonDidDisabled() {
        registerButton.isEnabled = false
        registerButton.alpha = 0.8
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
        self.registerButton.removeFromSuperview()
        
        self.accessoryView.addSubview(registerButton)
        self.accessoryView.addConstraints(registerButtonKeyboardConstraints())
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        self.registerButton.removeFromSuperview()
        
        self.contentsView.addSubview(registerButton)
        self.contentsView.addConstraints(registerButtonConstraints())
        
        scrollView.contentInset.bottom = 0
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightConditionLabel.removeFromSuperview()
        weightConditionLabel.removeFromSuperview()
        
        self.contentsView.addSubview(registerButton)
        self.contentsView.addConstraints(registerButtonConstraints())

        self.scrollView.contentSize = self.contentsView.frame.size
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension RegisterUserInfoViewController: UITextFieldDelegate {
    private func textFieldConditionChecking() {
        if nameCondition, birthCondition, heightCondition, weightCondition {
            registerButtonDidEnabled()
        } else {
            registerButtonDidDisabled()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            nameTextField.inputAccessoryView = self.accessoryView
            if nameConditionLabel.isDescendant(of: self.view) {
                nameConditionLabel.removeFromSuperview()
            }
        case birthTextField:
            birthTextField.inputAccessoryView = self.accessoryView
            if birthConditionLabel.isDescendant(of: self.view) {
                birthConditionLabel.removeFromSuperview()
            }
        case heightTextField:
            if let heightText = heightTextField.text {
                if heightText.count > 0 {
                    heightTextField.text?.removeLast()
                    heightTextField.text?.removeLast()
                    heightTextField.text?.removeLast()
                }
            }
            
            heightTextField.inputAccessoryView = self.accessoryView
            if heightConditionLabel.isDescendant(of: self.view) {
                heightConditionLabel.removeFromSuperview()
            }
        case weightTextField:
            scrollView.contentInset.bottom = keyboardHeight + 100.0
            
            if let weightText = weightTextField.text {
                if weightText.count > 0 {
                    weightTextField.text?.removeLast()
                    weightTextField.text?.removeLast()
                    weightTextField.text?.removeLast()
                }
            }
            
            weightTextField.inputAccessoryView = self.accessoryView
            if weightConditionLabel.isDescendant(of: self.view) {
                weightConditionLabel.removeFromSuperview()
            }
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        registerButtonDidDisabled()
        
        let currentCount = textField.text?.count ?? 0
        let replacementCount = currentCount + string.count - range.length
        
        switch textField {
        case nameTextField:
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
            
            if replacementCount <= 12 { return true }
            else { return false }
        case heightTextField:
            if currentCount == 2, string.count == 1 {
                heightTextField.text?.append(string)
                weightTextField.becomeFirstResponder()
                
                return false
            }
            
            if replacementCount <= 3 { return true }
            else { return false }
        case weightTextField:
            if currentCount == 1, string.count == 1 {
                weightTextField.text?.append(string)
                weightTextField.resignFirstResponder()
                
                return false
            } else if currentCount == 2, string.count == 1 {
                weightTextField.text?.append(string)
                weightTextField.resignFirstResponder()
                
                return false
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
            if nameTextCount < 2 {
                nameCondition = false
                nameConditionLabel.text = "이름은 2자 이상이여야 합니다"
                self.view.addSubview(nameConditionLabel)
                self.view.addConstraints(nameConditionLabelConstraints())
            } else if nameTextCount > 10 {
                nameCondition = false
                nameConditionLabel.text = "이름은 10자 이하여야 합니다"
                self.view.addSubview(nameConditionLabel)
                self.view.addConstraints(nameConditionLabelConstraints())
            } else {
                name = nameTextField.text ?? "default"
                nameCondition = true
            }
        case birthTextField:
            if let birthText = birthTextField.text {
                if birthText.count != 12 {
                    birthCondition = false
                    self.view.addSubview(birthConditionLabel)
                    self.view.addConstraints(birthConditionLabelConstraints())
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
                        birthCondition = false
                        self.view.addSubview(birthConditionLabel)
                        self.view.addConstraints(birthConditionLabelConstraints())
                    } else {
                        birthCondition = true
                        switch month {
                        case 1, 3, 5, 7, 8, 10, 12:
                            if day > 31 {
                                birthCondition = false
                                self.view.addSubview(birthConditionLabel)
                                self.view.addConstraints(birthConditionLabelConstraints())
                            }
                        case 4, 6, 9, 11:
                            if day > 30 {
                                birthCondition = false
                                self.view.addSubview(birthConditionLabel)
                                self.view.addConstraints(birthConditionLabelConstraints())
                            }
                        case 2:
                            if day > 29 {
                                birthCondition = false
                                self.view.addSubview(birthConditionLabel)
                                self.view.addConstraints(birthConditionLabelConstraints())
                            }
                        default:
                            birthCondition = false
                            self.view.addSubview(birthConditionLabel)
                            self.view.addConstraints(birthConditionLabelConstraints())
                        }
                    }
                }
            }
        case heightTextField:
            if let heightText = heightTextField.text {
                height = Int(heightText) ?? 0
                
                if height <= 0 || height > 300 {
                    heightCondition = false
                    heightTextField.text?.append(" cm")
                    self.view.addSubview(heightConditionLabel)
                    self.view.addConstraints(heightConditionLabelConstraints())
                } else {
                    heightTextField.text?.append(" cm")
                    heightCondition = true
                }
            }
        case weightTextField:
            if let weightText = weightTextField.text {
                weight = Int(weightText) ?? 0
                
                if weight <= 0 || weight > 400 {
                    weightCondition = false
                    weightTextField.text?.append(" kg")
                    self.view.addSubview(weightConditionLabel)
                    self.view.addConstraints(weightConditionLabelConstraints())
                } else {
                    weightTextField.text?.append(" kg")
                    weightCondition = true
                }
            }
        default:
            break
        }
        
        textFieldConditionChecking()
    }
}

extension RegisterUserInfoViewController {
    private func nameConditionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.nameConditionLabel, attribute: .top, relatedBy: .equal,
            toItem: self.nameTextField, attribute: .bottom, multiplier: 1.0, constant: 5.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.nameConditionLabel, attribute: .leading, relatedBy: .equal,
            toItem: self.nameTextField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.nameConditionLabel, attribute: .trailing, relatedBy: .equal,
            toItem: self.nameTextField, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    private func birthConditionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.birthConditionLabel, attribute: .top, relatedBy: .equal,
            toItem: self.birthTextField, attribute: .bottom, multiplier: 1.0, constant: 5.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.birthConditionLabel, attribute: .leading, relatedBy: .equal,
            toItem: self.birthTextField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.birthConditionLabel, attribute: .trailing, relatedBy: .equal,
            toItem: self.birthTextField, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    private func heightConditionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.heightConditionLabel, attribute: .top, relatedBy: .equal,
            toItem: self.heightTextField, attribute: .bottom, multiplier: 1.0, constant: 5.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.heightConditionLabel, attribute: .leading, relatedBy: .equal,
            toItem: self.heightTextField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.heightConditionLabel, attribute: .trailing, relatedBy: .equal,
            toItem: self.heightTextField, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    private func weightConditionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.weightConditionLabel, attribute: .top, relatedBy: .equal,
            toItem: self.weightTextField, attribute: .bottom, multiplier: 1.0, constant: 5.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.weightConditionLabel, attribute: .leading, relatedBy: .equal,
            toItem: self.weightTextField, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.weightConditionLabel, attribute: .trailing, relatedBy: .equal,
            toItem: self.weightTextField, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    private func registerButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.registerButton, attribute: .top, relatedBy: .equal,
            toItem: self.contentsView, attribute: .bottom, multiplier: 1.0, constant: -45.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.registerButton, attribute: .leading, relatedBy: .equal,
            toItem: self.contentsView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.registerButton, attribute: .trailing, relatedBy: .equal,
            toItem: self.contentsView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: self.registerButton, attribute: .bottom, relatedBy: .equal,
            toItem: self.contentsView, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func registerButtonKeyboardConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: self.registerButton, attribute: .top, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: self.registerButton, attribute: .leading, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: self.registerButton, attribute: .trailing, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: self.registerButton, attribute: .bottom, relatedBy: .equal,
            toItem: self.accessoryView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
}
