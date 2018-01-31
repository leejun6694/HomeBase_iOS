//
//  RegisterPlayerInfoViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 7..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterPlayerInfoViewController: UIViewController {
    
    // MARK: Properties
    
    var name: String = ""
    var year: String = ""
    var month: String = ""
    var day: String = ""
    var height: Int!
    var weight: Int!
    
    private var position: String = ""
    private var playerNumber: Int = 0
    private var pitcher: String = "우"
    private var hitter: String = "우"
    
    private var positionCondition = false
    private var playerNumberCondition = false
    
    private let correctColor = UIColor(red: 0.0,
                                       green: 180.0/255.0,
                                       blue: 223.0/255.0,
                                       alpha: 1.0)
    
    private let systemFont = UIFont.systemFont(ofSize: 13.0)
    private let barButtonFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 17.0)
    private let controlFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)
    
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
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet private weak var positionTextField: UITextField! {
        didSet { positionTextField.delegate = self }
    }
    @IBOutlet private weak var positionTextFieldBorder: UIView!
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
        
        let positionDoneButton = UIBarButtonItem(title: "완료",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(positionDoneButtonDidTapped(_:)))
        positionDoneButton.setTitleTextAttributes(
            [NSAttributedStringKey.font: barButtonFont ?? systemFont],
            for: .normal)
        positionDoneButton.tintColor = correctColor
        let positionSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
        let positionCancelButton = UIBarButtonItem(title: "취소",
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(positionCancelButtondDidTapped(_:)))
        positionCancelButton.setTitleTextAttributes(
            [NSAttributedStringKey.font: barButtonFont ?? systemFont],
            for: .normal)
        positionCancelButton.tintColor = correctColor
        toolBar.setItems([positionCancelButton, positionSpaceItem, positionDoneButton], animated: false)
        
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
    
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet private weak var playerNumberTextField: UITextField! {
        didSet { playerNumberTextField.delegate = self }
    }
    @IBOutlet private weak var playerNumberTextFieldBorder: UIView!
    private lazy var playerNumberConditionImageView: UIImageView = {
        let playerNumberConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        playerNumberConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return playerNumberConditionImageView
    }()
    
    @IBOutlet weak var pitcherLabel: UILabel!
    @IBOutlet private weak var pitcherControl: UISegmentedControl! {
        didSet {
            pitcherControl.setTitleTextAttributes(
                [NSAttributedStringKey.font: controlFont ?? systemFont],
                for: .normal)
        }
    }
    
    @IBOutlet weak var hitterLabel: UILabel!
    @IBOutlet private weak var hitterControl: UISegmentedControl! {
        didSet {
            hitterControl.setTitleTextAttributes(
                [NSAttributedStringKey.font: controlFont ?? systemFont],
                for: .normal)
        }
    }
    
    // MARK: Methods
    
    @IBAction func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func doneButtonDidTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        spinnerStartAnimating(spinner)
        
        if let currentUser = Auth.auth().currentUser {
            let ref = Database.database().reference()
            
            var provider:String = ""
            for profile in currentUser.providerData {
                provider = profile.providerID
            }
            
            var batPosition = "우"
            let hitterControlValue = hitterControl.selectedSegmentIndex
            if hitterControlValue == 0 { batPosition = "좌" }
            else { batPosition = "우" }
            
            var pitchPosition = "우"
            let pitcherControlValue = pitcherControl.selectedSegmentIndex
            if pitcherControlValue == 0 { pitchPosition = "좌" }
            else { pitchPosition = "우" }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let joinedAt = dateFormatter.string(from: Date())
            
            ref.child("users").child(currentUser.uid).updateChildValues(
                ["email": currentUser.email ?? "no email",
                 "name": name,
                 "birth": "\(year).\(month).\(day)",
                 "provider": provider])
            
            ref.child("players").child(currentUser.uid).setValue(
                ["name": name,
                 "height": height,
                 "weight": weight,
                 "position": position,
                 "backNumber": playerNumber,
                 "batPosition": batPosition,
                 "pitchPosition": pitchPosition,
                 "joinedAt": joinedAt])
            
            spinnerStopAnimating(spinner)
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                
                UIApplication.shared.keyWindow?.rootViewController = mainViewController
            }
        } else {
            spinnerStopAnimating(spinner)
        }
    }
    
    @objc private func positionDoneButtonDidTapped(_ sender: UIBarButtonItem) {
        positionTextFieldCondition(true)
        playerNumberTextField.becomeFirstResponder()
    }
    
    @objc private func positionCancelButtondDidTapped(_ sender: UIBarButtonItem) {
        positionTextFieldCondition(false)
        positionTextField.text = nil
        positionTextField.resignFirstResponder()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        doneButton.removeFromSuperview()
        accessoryView.addSubview(doneButton)
        accessoryView.addConstraints(doneButtonKeyboardConstraints())
    }
    
    @objc private func keyboardWillHide(_ notification:NSNotification) {
        doneButton.removeFromSuperview()
        self.view.addSubview(doneButton)
        self.view.addConstraints(doneButtonConstraints())
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.titleView = titleLabel
    }
}

extension RegisterPlayerInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Custom Methods
    
    private func positionTextFieldCondition(_ state: Bool) {
        if state {
            positionCondition = true
            position = positionTextField.text ?? "default"
            positionLabel.textColor = correctColor
            positionTextField.textColor = correctColor
            positionTextField.tintColor = correctColor
            positionTextFieldBorder.backgroundColor = correctColor
            
            if !positionConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(positionConditionImageView)
                self.view.addConstraints(positionConditionImageViewConstraints())
            }
        } else {
            positionCondition = false
            position = positionTextField.text ?? "default"
            positionLabel.textColor = .white
            positionTextField.textColor = .white
            positionTextField.tintColor = .white
            positionTextFieldBorder.backgroundColor = .white
            
            if positionConditionImageView.isDescendant(of: self.view) {
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

extension RegisterPlayerInfoViewController: UITextFieldDelegate {
    
    // MARK: Custom Methods
    
    private func textFieldConditionChecked() {
        if positionCondition, playerNumberCondition {
            buttonEnabled(doneButton)
            
            pitcherLabel.textColor = correctColor
            hitterLabel.textColor = correctColor
        } else {
            buttonDisabled(doneButton)
            
            pitcherLabel.textColor = .white
            hitterLabel.textColor = .white
        }
    }
    
    private func playerNumberTextFieldCondition(_ state: Bool) {
        if state {
            playerNumberCondition = true
            playerNumber = Int(playerNumberTextField.text ?? "0") ?? 0
            playerNumberLabel.textColor = correctColor
            playerNumberTextField.textColor = correctColor
            playerNumberTextField.tintColor = correctColor
            playerNumberTextFieldBorder.backgroundColor = correctColor
            
            if !playerNumberConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(playerNumberConditionImageView)
                self.view.addConstraints(playerNumberConditionImageViewConstraints())
            }
        } else {
            playerNumberCondition = false
            playerNumber = Int(playerNumberTextField.text ?? "0") ?? 0
            playerNumberLabel.textColor = .white
            playerNumberTextField.textColor = .white
            playerNumberTextField.tintColor = .white
            playerNumberTextFieldBorder.backgroundColor = .white
            
            if playerNumberConditionImageView.isDescendant(of: self.view) {
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
        case playerNumberTextField:
            playerNumberTextField.inputAccessoryView = accessoryView
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
        switch textField {
        case playerNumberTextField:
            playerNumberTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
//        case positionTextField:
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

extension RegisterPlayerInfoViewController {
    private func positionConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: positionTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: positionTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: positionTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: positionTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func playerNumberConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: playerNumberConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: playerNumberTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: playerNumberConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: playerNumberTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerNumberConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: playerNumberTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerNumberConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: playerNumberTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
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
