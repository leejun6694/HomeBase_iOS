//
//  PersonalSettingUserView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 7. 4..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalSettingUserView: UIView {
    
    // MARK: Properties
    
    var name: String = "" {
        didSet {
            nameTextField.text = name
        }
    }
    var birth: String = "" {
        didSet {
            birthTextField.text = birth
        }
    }
    var height: Int = 0 {
        didSet {
            heightTextField.text = "\(height) cm"
        }
    }
    var weight: Int = 0 {
        didSet {
            weightTextField.text = "\(weight) kg"
        }
    }
    
    private var year: String = ""
    private var month: String = ""
    private var day: String = ""
    
    var userCondition = true
    private var nameCondition = true
    private var birthCondition = true
    private var heightCondition = true
    private var weightCondition = true

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이름"
        nameLabel.textColor = HBColor.correct
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.textColor = HBColor.correct
        nameTextField.tintColor = HBColor.correct
        nameTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.minimumFontSize = 9.0
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.delegate = self
        
        return nameTextField
    }()
    private lazy var nameTextFieldBorder: UIView = {
        let nameTextFieldBorder = UIView()
        nameTextFieldBorder.backgroundColor = HBColor.correct
        nameTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return nameTextFieldBorder
    }()
    private lazy var nameConditionImageView: UIImageView = {
        let nameConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        nameConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameConditionImageView
    }()
    
    private lazy var birthLabel: UILabel = {
        let birthLabel = UILabel()
        birthLabel.text = "생년월일"
        birthLabel.textColor = HBColor.correct
        birthLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        birthLabel.textAlignment = .left
        birthLabel.adjustsFontSizeToFitWidth = true
        birthLabel.minimumScaleFactor = 0.5
        birthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return birthLabel
    }()
    lazy var birthTextField: UITextField = {
        let birthTextField = UITextField()
        birthTextField.textColor = HBColor.correct
        birthTextField.tintColor = HBColor.correct
        birthTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        birthTextField.adjustsFontSizeToFitWidth = true
        birthTextField.minimumFontSize = 9.0
        birthTextField.translatesAutoresizingMaskIntoConstraints = false
        birthTextField.delegate = self
        birthTextField.keyboardType = .numberPad
        
        return birthTextField
    }()
    private lazy var birthTextFieldBorder: UIView = {
        let birthTextFieldBorder = UIView()
        birthTextFieldBorder.backgroundColor = HBColor.correct
        birthTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return birthTextFieldBorder
    }()
    private lazy var birthConditionImageView: UIImageView = {
        let birthConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        birthConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return birthConditionImageView
    }()
    
    private lazy var heightLabel: UILabel = {
        let heightLabel = UILabel()
        heightLabel.text = "신장"
        heightLabel.textColor = HBColor.correct
        heightLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        heightLabel.textAlignment = .left
        heightLabel.adjustsFontSizeToFitWidth = true
        heightLabel.minimumScaleFactor = 0.5
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return heightLabel
    }()
    lazy var heightTextField: UITextField = {
        let heightTextField = UITextField()
        heightTextField.textColor = HBColor.correct
        heightTextField.tintColor = HBColor.correct
        heightTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        heightTextField.adjustsFontSizeToFitWidth = true
        heightTextField.minimumFontSize = 9.0
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        heightTextField.delegate = self
        heightTextField.keyboardType = .numberPad
        
        return heightTextField
    }()
    private lazy var heightTextFieldBorder: UIView = {
        let heightTextFieldBorder = UIView()
        heightTextFieldBorder.backgroundColor = HBColor.correct
        heightTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return heightTextFieldBorder
    }()
    private lazy var heightConditionImageView: UIImageView = {
        let heightConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        heightConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return heightConditionImageView
    }()
    
    private lazy var weightLabel: UILabel = {
        let weightLabel = UILabel()
        weightLabel.text = "체중"
        weightLabel.textColor = HBColor.correct
        weightLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        weightLabel.textAlignment = .left
        weightLabel.adjustsFontSizeToFitWidth = true
        weightLabel.minimumScaleFactor = 0.5
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return weightLabel
    }()
    lazy var weightTextField: UITextField = {
        let weightTextField = UITextField()
        weightTextField.textColor = HBColor.correct
        weightTextField.tintColor = HBColor.correct
        weightTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        weightTextField.adjustsFontSizeToFitWidth = true
        weightTextField.minimumFontSize = 9.0
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.delegate = self
        weightTextField.keyboardType = .numberPad
        
        return weightTextField
    }()
    private lazy var weightTextFieldBorder: UIView = {
        let weightTextFieldBorder = UIView()
        weightTextFieldBorder.backgroundColor = HBColor.correct
        weightTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return weightTextFieldBorder
    }()
    private lazy var weightConditionImageView: UIImageView = {
        let weightConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        weightConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return weightConditionImageView
    }()
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(nameLabel)
        self.addConstraints(nameLabelConstraints())
        self.addSubview(nameTextField)
        self.addConstraints(nameTextFieldConstraints())
        self.addSubview(nameTextFieldBorder)
        self.addConstraints(nameTextFieldBorderConstraints())
        self.addSubview(nameConditionImageView)
        self.addConstraints(nameConditionImageViewConstraints())
        
        self.addSubview(birthLabel)
        self.addConstraints(birthLabelConstraints())
        self.addSubview(birthTextField)
        self.addConstraints(birthTextFieldConstraints())
        self.addSubview(birthTextFieldBorder)
        self.addConstraints(birthTextFieldBorderConstraints())
        self.addSubview(birthConditionImageView)
        self.addConstraints(birthConditionImageViewConstraints())
        
        self.addSubview(heightLabel)
        self.addConstraints(heightLabelConstraints())
        self.addSubview(heightTextField)
        self.addConstraints(heightTextFieldConstraints())
        self.addSubview(heightTextFieldBorder)
        self.addConstraints(heightTextFieldBorderConstraints())
        self.addSubview(heightConditionImageView)
        self.addConstraints(heightConditionImageViewConstraints())
        
        self.addSubview(weightLabel)
        self.addConstraints(weightLabelConstraints())
        self.addSubview(weightTextField)
        self.addConstraints(weightTextFieldConstraints())
        self.addSubview(weightTextFieldBorder)
        self.addConstraints(weightTextFieldBorderConstraints())
        self.addSubview(weightConditionImageView)
        self.addConstraints(weightConditionImageViewConstraints())
    }
}

// MARK:- TextField Delegate
extension PersonalSettingUserView: UITextFieldDelegate {
    private func textFieldConditionChecked() {
        if nameCondition, birthCondition, heightCondition, weightCondition {
            userCondition = true
        } else {
            userCondition = false
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
            
            if !nameConditionImageView.isDescendant(of: self) {
                self.addSubview(nameConditionImageView)
                self.addConstraints(nameConditionImageViewConstraints())
            }
        } else {
            nameCondition = false
            nameLabel.textColor = .white
            nameTextField.textColor = .white
            nameTextField.tintColor = .white
            nameTextFieldBorder.backgroundColor = .white
            
            if nameConditionImageView.isDescendant(of: self) {
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
            
            if !birthConditionImageView.isDescendant(of: self) {
                self.addSubview(birthConditionImageView)
                self.addConstraints(birthConditionImageViewConstraints())
            }
        } else {
            birthCondition = false
            birthLabel.textColor = .white
            birthTextField.textColor = .white
            birthTextField.tintColor = .white
            birthTextFieldBorder.backgroundColor = .white
            
            if birthConditionImageView.isDescendant(of: self) {
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
            
            if !heightConditionImageView.isDescendant(of: self) {
                self.addSubview(heightConditionImageView)
                self.addConstraints(heightConditionImageViewConstraints())
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
            
            if heightConditionImageView.isDescendant(of: self) {
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
            
            if !weightConditionImageView.isDescendant(of: self) {
                self.addSubview(weightConditionImageView)
                self.addConstraints(weightConditionImageViewConstraints())
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
            
            if weightConditionImageView.isDescendant(of: self) {
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
        case birthTextField:
            birthTextFieldCondition(birthChecked(birthTextField))
        case heightTextField:
            let heightText = heightTextField.text ?? ""
            if heightText.contains("cm") {
                heightTextField.text?.removeLast()
                heightTextField.text?.removeLast()
                heightTextField.text?.removeLast()
            }
            
            heightTextFieldCondition(bodyChecked(heightTextField))
        case weightTextField:
            let weightText = weightTextField.text ?? ""
            if weightText.contains("kg") {
                weightTextField.text?.removeLast()
                weightTextField.text?.removeLast()
                weightTextField.text?.removeLast()
            }
            
            weightTextFieldCondition(bodyChecked(weightTextField))
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        buttonDisabled(doneButton)
        
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

extension PersonalSettingUserView {
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 20/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 60/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 19/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func nameTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: nameTextField, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: nameTextField, attribute: .top, relatedBy: .equal,
            toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameTextField, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameTextField, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 37/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func nameTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: nameTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: nameTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: nameTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/426, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
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
            toItem: nameConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func birthLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: birthLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: birthLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 104/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: birthLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 60/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: birthLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 19/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func birthTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: birthTextField, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: birthTextField, attribute: .top, relatedBy: .equal,
            toItem: birthLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: birthTextField, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: birthTextField, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 37/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func birthTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: birthTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: birthTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: birthTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: birthTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: birthTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/426, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
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
    
    private func heightLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: heightLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: heightLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 203/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: heightLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 60/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: heightLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 19/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func heightTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: heightTextField, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: heightTextField, attribute: .top, relatedBy: .equal,
            toItem: heightLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: heightTextField, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: heightTextField, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 37/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func heightTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: heightTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: heightTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: heightTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: heightTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: heightTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/426, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
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
    
    private func weightLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: weightLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: weightLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 287/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: weightLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 60/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: weightLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 19/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func weightTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: weightTextField, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: weightTextField, attribute: .top, relatedBy: .equal,
            toItem: weightLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: weightTextField, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: weightTextField, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 37/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func weightTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: weightTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: weightTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: weightTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: weightTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: weightTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/426, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
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
}
