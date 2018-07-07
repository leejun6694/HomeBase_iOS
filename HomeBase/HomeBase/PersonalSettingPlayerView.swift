//
//  PersonalSettingPlayerView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 7. 4..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalSettingPlayerView: UIView {
    
    // MARK: Properties
    
    var dbPosition: String = "" {
        didSet {
            positionTextField.text = dbPosition
        }
    }
    var dbPlayerNumber: Int = 0 {
        didSet {
            playerNumberTextField.text = "\(dbPlayerNumber)"
        }
    }
    var dbPitcher: String = "우" {
        didSet {
            if dbPitcher == "좌" {
                pitcherControl.selectedSegmentIndex = 0
            } else {
                pitcherControl.selectedSegmentIndex = 1
            }
        }
    }
    var dbHitter: String = "우" {
        didSet {
            if dbHitter == "좌" {
                hitterControl.selectedSegmentIndex = 0
            } else {
                hitterControl.selectedSegmentIndex = 1
            }
        }
    }
    
    var position: String = ""
    var playerNumber: Int = 0
    var pitcher: String = ""
    var hitter: String = ""
    
    var playerCondition = true
    private var positionCondition = true
    private var playerNumberCondition = true
    
    private let systemFont = UIFont.systemFont(ofSize: 13.0)
    private let barButtonFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 17.0)
    private let controlFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)
    
    private lazy var positionLabel: UILabel = {
        let positionLabel = UILabel()
        positionLabel.text = "포지션"
        positionLabel.textColor = HBColor.correct
        positionLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        positionLabel.textAlignment = .left
        positionLabel.adjustsFontSizeToFitWidth = true
        positionLabel.minimumScaleFactor = 0.5
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return positionLabel
    }()
    lazy var positionTextField: UITextField = {
        let positionTextField = UITextField()
        positionTextField.textColor = HBColor.correct
        positionTextField.tintColor = HBColor.correct
        positionTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        positionTextField.adjustsFontSizeToFitWidth = true
        positionTextField.minimumFontSize = 9.0
        positionTextField.translatesAutoresizingMaskIntoConstraints = false
        positionTextField.delegate = self
        
        return positionTextField
    }()
    private lazy var positionTextFieldBorder: UIView = {
        let positionTextFieldBorder = UIView()
        positionTextFieldBorder.backgroundColor = HBColor.correct
        positionTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return positionTextFieldBorder
    }()
    private lazy var positionConditionImageView: UIImageView = {
        let positionConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        positionConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return positionConditionImageView
    }()
    private lazy var pickerToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        toolBar.sizeToFit()
        
        let positionDoneButton = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(positionDoneButtonDidTapped(_:)))
        positionDoneButton.setTitleTextAttributes(
            [NSAttributedStringKey.font: barButtonFont ?? systemFont],
            for: .normal)
        positionDoneButton.tintColor = HBColor.correct
        let positionSpaceItem = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let positionCancelButton = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(positionCancelButtondDidTapped(_:)))
        positionCancelButton.setTitleTextAttributes(
            [NSAttributedStringKey.font: barButtonFont ?? systemFont],
            for: .normal)
        positionCancelButton.tintColor = HBColor.correct
        toolBar.setItems(
            [positionCancelButton,
             positionSpaceItem,
             positionDoneButton],
            animated: false)
        
        return toolBar
    }()
    private let positionData: [String] = ["선발투수", "중간계투", "마무리투수",
                                          "포수", "1루수", "2루수",
                                          "3루수", "유격수", "좌익수",
                                          "중견수", "우익수", "지명타자"]
    private let subData: [String] = ["SP", "RP", "CP",
                                     "C", "1B", "2B",
                                     "3B", "SS", "LF",
                                     "CF", "RF", "DH"]
    
    private lazy var positionPickerView: UIPickerView = {
        let positionPickerView = UIPickerView()
        positionPickerView.backgroundColor = .white
        positionPickerView.delegate = self
        
        return positionPickerView
    }()
    
    private lazy var playerNumberLabel: UILabel = {
        let playerNumberLabel = UILabel()
        playerNumberLabel.text = "선수번호"
        playerNumberLabel.textColor = HBColor.correct
        playerNumberLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        playerNumberLabel.textAlignment = .left
        playerNumberLabel.adjustsFontSizeToFitWidth = true
        playerNumberLabel.minimumScaleFactor = 0.5
        playerNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return playerNumberLabel
    }()
    lazy var playerNumberTextField: UITextField = {
        let playerNumberTextField = UITextField()
        playerNumberTextField.textColor = HBColor.correct
        playerNumberTextField.tintColor = HBColor.correct
        playerNumberTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        playerNumberTextField.adjustsFontSizeToFitWidth = true
        playerNumberTextField.minimumFontSize = 9.0
        playerNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        playerNumberTextField.keyboardType = .numberPad
        playerNumberTextField.delegate = self
        
        return playerNumberTextField
    }()
    private lazy var playerNumberTextFieldBorder: UIView = {
        let playerNumberTextFieldBorder = UIView()
        playerNumberTextFieldBorder.backgroundColor = HBColor.correct
        playerNumberTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return playerNumberTextFieldBorder
    }()
    private lazy var playerNumberConditionImageView: UIImageView = {
        let playerNumberConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        playerNumberConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return playerNumberConditionImageView
    }()
    
    private lazy var pitcherLabel: UILabel = {
        let pitcherLabel = UILabel()
        pitcherLabel.text = "투수"
        pitcherLabel.textColor = HBColor.correct
        pitcherLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        pitcherLabel.textAlignment = .left
        pitcherLabel.adjustsFontSizeToFitWidth = true
        pitcherLabel.minimumScaleFactor = 0.5
        pitcherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pitcherLabel
    }()
    lazy var pitcherControl: UISegmentedControl = {
        let pitcherControl = UISegmentedControl(items: ["좌", "우"])
        pitcherControl.tintColor = HBColor.correct
        pitcherControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pitcherControl
    }()
    
    private lazy var hitterLabel: UILabel = {
        let hitterLabel = UILabel()
        hitterLabel.text = "타자"
        hitterLabel.textColor = HBColor.correct
        hitterLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        hitterLabel.textAlignment = .left
        hitterLabel.adjustsFontSizeToFitWidth = true
        hitterLabel.minimumScaleFactor = 0.5
        hitterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return hitterLabel
    }()
    lazy var hitterControl: UISegmentedControl = {
        let hitterControl = UISegmentedControl(items: ["좌", "우"])
        hitterControl.tintColor = HBColor.correct
        hitterControl.translatesAutoresizingMaskIntoConstraints = false
        
        return hitterControl
    }()
    
    // MARK: Methods
    
    @objc private func positionDoneButtonDidTapped(_ sender: UIBarButtonItem) {
        positionTextFieldCondition(true)
        playerNumberTextField.becomeFirstResponder()
    }
    
    @objc private func positionCancelButtondDidTapped(_ sender: UIBarButtonItem) {
        positionTextFieldCondition(false)
        positionTextField.text = nil
        positionTextField.resignFirstResponder()
    }
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        position = dbPosition
        playerNumber = dbPlayerNumber
        pitcher = dbPitcher
        hitter = dbHitter
        
        self.addSubview(positionLabel)
        self.addConstraints(positionLabelConstraints())
        self.addSubview(positionTextField)
        self.addConstraints(positionTextFieldConstraints())
        self.addSubview(positionTextFieldBorder)
        self.addConstraints(positionTextFieldBorderConstraints())
        self.addSubview(positionConditionImageView)
        self.addConstraints(positionConditionImageViewConstraints())
        
        self.addSubview(playerNumberLabel)
        self.addConstraints(playerNumberLabelConstraints())
        self.addSubview(playerNumberTextField)
        self.addConstraints(playerNumberTextFieldConstraints())
        self.addSubview(playerNumberTextFieldBorder)
        self.addConstraints(playerNumberTextFieldBorderConstraints())
        self.addSubview(playerNumberConditionImageView)
        self.addConstraints(playerNumberConditionImageViewConstraints())
        
        self.addSubview(pitcherLabel)
        self.addConstraints(pitcherLabelConstraints())
        self.addSubview(pitcherControl)
        self.addConstraints(pitcherControlConstraints())
        
        self.addSubview(hitterLabel)
        self.addConstraints(hitterLabelConstraints())
        self.addSubview(hitterControl)
        self.addConstraints(hitterControlConstraints())
    }
}

extension PersonalSettingPlayerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Custom Methods
    
    private func positionTextFieldCondition(_ state: Bool) {
        if state {
            positionCondition = true
            position = positionTextField.text ?? "default"
            positionLabel.textColor = HBColor.correct
            positionTextField.textColor = HBColor.correct
            positionTextField.tintColor = HBColor.correct
            positionTextFieldBorder.backgroundColor = HBColor.correct
            
            if !positionConditionImageView.isDescendant(of: self) {
                self.addSubview(positionConditionImageView)
                self.addConstraints(positionConditionImageViewConstraints())
            }
        } else {
            positionCondition = false
            position = positionTextField.text ?? "default"
            positionLabel.textColor = .white
            positionTextField.textColor = .white
            positionTextField.tintColor = .white
            positionTextFieldBorder.backgroundColor = .white
            
            if positionConditionImageView.isDescendant(of: self) {
                positionConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    // MARK: PickerView Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return positionData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        pickerLabel.textColor = .black
        pickerLabel.textAlignment = .center
        pickerLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 19.0)
        pickerLabel.text = "\(positionData[row]) (\(subData[row]))"
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        positionTextField.text = positionData[row]
        positionTextFieldCondition(true)
    }
}

extension PersonalSettingPlayerView: UITextFieldDelegate {
    // MARK: Custom Methods
    
    private func textFieldConditionChecked() {
        if positionCondition, playerNumberCondition {
            playerCondition = true
        } else {
            playerCondition = false
        }
    }
    
    private func playerNumberTextFieldCondition(_ state: Bool) {
        if state {
            playerNumberCondition = true
            playerNumber = Int(playerNumberTextField.text ?? "0") ?? 0
            playerNumberLabel.textColor = HBColor.correct
            playerNumberTextField.textColor = HBColor.correct
            playerNumberTextField.tintColor = HBColor.correct
            playerNumberTextFieldBorder.backgroundColor = HBColor.correct
            
            if !playerNumberConditionImageView.isDescendant(of: self) {
                self.addSubview(playerNumberConditionImageView)
                self.addConstraints(playerNumberConditionImageViewConstraints())
            }
        } else {
            playerNumberCondition = false
            playerNumber = Int(playerNumberTextField.text ?? "0") ?? 0
            playerNumberLabel.textColor = .white
            playerNumberTextField.textColor = .white
            playerNumberTextField.tintColor = .white
            playerNumberTextFieldBorder.backgroundColor = .white
            
            if playerNumberConditionImageView.isDescendant(of: self) {
                playerNumberConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    // MARK: TextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case positionTextField:
            positionTextField.text = "선발투수"
            
            positionTextField.inputView = positionPickerView
            positionTextField.inputAccessoryView = pickerToolBar
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.count ?? 0
        let replacementCount = currentCount + string.count - range.length
        
        switch textField {
        case playerNumberTextField:
            if currentCount == 1, string.count == 1 {
                if playerNumberTextField.text == "0" {
                    playerNumberTextField.text?.removeLast()
                }
            }
            
            if currentCount == 2, string.count == 1 {
                playerNumberTextField.text?.append(string)
                playerNumberTextField.resignFirstResponder()
                
                return false
            }
            
            if currentCount == 0, string.count == 1 {
                playerNumberTextFieldCondition(true)
            } else if replacementCount > 0 {
                playerNumberTextFieldCondition(true)
            } else {
                playerNumberTextFieldCondition(false)
            }
            
            if replacementCount < 4 { return true }
            else { return false }
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case playerNumberTextField:
            let playerNumberText = playerNumberTextField.text ?? ""
            if playerNumberText.count > 0, playerNumberText.count < 4 {
                playerNumberTextFieldCondition(true)
            } else {
                playerNumberTextFieldCondition(false)
            }
        default:
            break
        }
    }
}

extension PersonalSettingPlayerView {
    private func positionLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 42/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 60/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 19/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func positionTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: positionTextField, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: positionTextField, attribute: .top, relatedBy: .equal,
            toItem: positionLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionTextField, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionTextField, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 37/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func positionTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: positionTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: positionTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: positionTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/426, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func positionConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: positionTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: positionTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: positionTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: positionConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func playerNumberLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: playerNumberLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: playerNumberLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 141/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerNumberLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 60/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerNumberLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 19/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func playerNumberTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: playerNumberTextField, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: playerNumberTextField, attribute: .top, relatedBy: .equal,
            toItem: playerNumberLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerNumberTextField, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerNumberTextField, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 37/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func playerNumberTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: playerNumberTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: playerNumberTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: playerNumberTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerNumberTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerNumberTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/426, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func playerNumberConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: playerNumberConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: playerNumberTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: playerNumberConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: playerNumberTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerNumberConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: playerNumberTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerNumberConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: playerNumberConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: pitcherLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: pitcherLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 251/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 50/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func pitcherControlConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: pitcherControl, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 219/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: pitcherControl, attribute: .centerY, relatedBy: .equal,
            toItem: pitcherLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherControl, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 153/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherControl, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 30/426, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func hitterLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: hitterLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: hitterLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 325/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: hitterLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 50/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: hitterLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func hitterControlConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: hitterControl, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 219/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: hitterControl, attribute: .centerY, relatedBy: .equal,
            toItem: hitterLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: hitterControl, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 153/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: hitterControl, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 30/426, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
