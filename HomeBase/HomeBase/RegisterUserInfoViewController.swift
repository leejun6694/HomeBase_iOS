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
    
    var name: String = ""
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var height: Int = 0
    var weight: Int = 0
    
    var nameCondition = false
    var birthCondition = false
    var heightCondition = false
    var weightCondition = false
    
    var keyboardHeight: CGFloat = 0
    
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
        registerButton.setTitle("완료", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = UIColor(red: 75.0/255.0,
                                                 green: 75.0/255.0,
                                                 blue: 75.0/255.0,
                                                 alpha: 0.8)
        registerButton.isEnabled = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        return registerButton
    }()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet {
            bottomBorderWith(nameTextField)
            nameTextField.delegate = self
        }
    }
    @IBOutlet private var nameConditionLabel: UILabel! {
        didSet {
            nameConditionLabel.text = "올바르지 않은 이름입니다"
            nameConditionLabel.textColor = .red
            nameConditionLabel.removeFromSuperview()
        }
    }
    
    @IBOutlet private weak var birthTextField: UITextField! {
        didSet {
            bottomBorderWith(birthTextField)
            birthTextField.delegate = self
        }
    }
    @IBOutlet var birthConditionLabel: UILabel! {
        didSet {
            birthConditionLabel.text = "유효한 생년월일을 입력해주세요"
            birthConditionLabel.textColor = .red
            birthConditionLabel.removeFromSuperview()
        }
    }
    
    @IBOutlet private weak var heightTextField: UITextField! {
        didSet {
            bottomBorderWith(heightTextField)
            heightTextField.delegate = self
        }
    }
    @IBOutlet var heightConditionLabel: UILabel! {
        didSet {
            heightConditionLabel.text = "유효한 신장을 입력해주세요"
            heightConditionLabel.textColor = .red
            heightConditionLabel.removeFromSuperview()
        }
    }
    
    @IBOutlet private weak var weightTextField: UITextField! {
        didSet {
            bottomBorderWith(weightTextField)
            weightTextField.delegate = self
        }
    }
    
    // MARK: Methods
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.accessoryView.addSubview(registerButton)
        self.accessoryView.addConstraints(registerButtonConstraints())
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
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
    private func textFieldCondition(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            let nameTextCount = nameTextField.text?.count ?? 0
            if nameTextCount < 2 {
                nameCondition = false
                nameConditionLabel.text = "이름은 2자 이상이여야 합니다"
                self.view.addSubview(nameConditionLabel)
            } else if nameTextCount > 10 {
                nameCondition = false
                nameConditionLabel.text = "이름은 10자 이하여야 합니다"
                self.view.addSubview(nameConditionLabel)
            } else {
                name = nameTextField.text ?? "default"
                nameCondition = true
            }
        case birthTextField:
            if let birthText = birthTextField.text {
                if birthText.count != 12 {
                    birthCondition = false
                    self.view.addSubview(birthConditionLabel)
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
                    } else {
                        birthCondition = true
                        switch month {
                        case 1, 3, 5, 7, 8, 10, 12:
                            if day > 31 {
                                birthCondition = false
                                self.view.addSubview(birthConditionLabel)
                            }
                        case 4, 6, 9, 11:
                            if day > 30 {
                                birthCondition = false
                                self.view.addSubview(birthConditionLabel)
                            }
                        case 2:
                            if day > 29 {
                                birthCondition = false
                                self.view.addSubview(birthConditionLabel)
                            }
                        default:
                            birthCondition = false
                            self.view.addSubview(birthConditionLabel)
                        }
                    }
                }
            }
        case heightTextField:
            if let heightText = heightTextField.text {
                height = Int(heightText) ?? 0
                
                heightTextField.text?.append(" cm")
                
                if height < 0 || height > 300 {
                    heightCondition = false
                    self.view.addSubview(heightConditionLabel)
                } else {
                    heightCondition = true
                }
            }
        default:
            break
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
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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
                scrollView.contentInset.bottom = keyboardHeight + 100.0
                
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
        textFieldCondition(textField)
    }
}

extension RegisterUserInfoViewController {
    private func registerButtonConstraints() -> [NSLayoutConstraint] {
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
