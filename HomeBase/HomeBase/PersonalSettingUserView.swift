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

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이름"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.textColor = .white
        nameTextField.tintColor = .white
        nameTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.minimumFontSize = 9.0
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return nameTextField
    }()
    private lazy var nameTextFieldBorder: UIView = {
        let nameTextFieldBorder = UIView()
        nameTextFieldBorder.backgroundColor = .white
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
        birthLabel.textColor = .white
        birthLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        birthLabel.textAlignment = .left
        birthLabel.adjustsFontSizeToFitWidth = true
        birthLabel.minimumScaleFactor = 0.5
        birthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return birthLabel
    }()
    lazy var birthTextField: UITextField = {
        let birthTextField = UITextField()
        birthTextField.textColor = .white
        birthTextField.tintColor = .white
        birthTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        birthTextField.adjustsFontSizeToFitWidth = true
        birthTextField.minimumFontSize = 9.0
        birthTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return birthTextField
    }()
    private lazy var birthTextFieldBorder: UIView = {
        let birthTextFieldBorder = UIView()
        birthTextFieldBorder.backgroundColor = .white
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
        heightLabel.textColor = .white
        heightLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        heightLabel.textAlignment = .left
        heightLabel.adjustsFontSizeToFitWidth = true
        heightLabel.minimumScaleFactor = 0.5
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return heightLabel
    }()
    lazy var heightTextField: UITextField = {
        let heightTextField = UITextField()
        heightTextField.textColor = .white
        heightTextField.tintColor = .white
        heightTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        heightTextField.adjustsFontSizeToFitWidth = true
        heightTextField.minimumFontSize = 9.0
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return heightTextField
    }()
    private lazy var heightTextFieldBorder: UIView = {
        let heightTextFieldBorder = UIView()
        heightTextFieldBorder.backgroundColor = .white
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
        weightLabel.textColor = .white
        weightLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        weightLabel.textAlignment = .left
        weightLabel.adjustsFontSizeToFitWidth = true
        weightLabel.minimumScaleFactor = 0.5
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return weightLabel
    }()
    lazy var weightTextField: UITextField = {
        let weightTextField = UITextField()
        weightTextField.textColor = .white
        weightTextField.tintColor = .white
        weightTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        weightTextField.adjustsFontSizeToFitWidth = true
        weightTextField.minimumFontSize = 9.0
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return weightTextField
    }()
    private lazy var weightTextFieldBorder: UIView = {
        let weightTextFieldBorder = UIView()
        weightTextFieldBorder.backgroundColor = .white
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
        
        self.addSubview(birthLabel)
        self.addConstraints(birthLabelConstraints())
        self.addSubview(birthTextField)
        self.addConstraints(birthTextFieldConstraints())
        self.addSubview(birthTextFieldBorder)
        self.addConstraints(birthTextFieldBorderConstraints())
        
        self.addSubview(heightLabel)
        self.addConstraints(heightLabelConstraints())
        self.addSubview(heightTextField)
        self.addConstraints(heightTextFieldConstraints())
        self.addSubview(heightTextFieldBorder)
        self.addConstraints(heightTextFieldBorderConstraints())
        
        self.addSubview(weightLabel)
        self.addConstraints(weightLabelConstraints())
        self.addSubview(weightTextField)
        self.addConstraints(weightTextFieldConstraints())
        self.addSubview(weightTextFieldBorder)
        self.addConstraints(weightTextFieldBorderConstraints())
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
            toItem: self, attribute: .centerY, multiplier: 195/213, constant: 0.0)
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
            toItem: self, attribute: .centerY, multiplier: 297/213, constant: 0.0)
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
