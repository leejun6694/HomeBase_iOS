//
//  ScheduleCreateViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 27..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ScheduleCreateViewController: UIViewController {

    // MARK: Properties
    
    private var opponentTeam: String = ""
    private var matchPlace: String = ""
    private var matchDate: String = ""
    
    private var opponentTeamCondition = false
    private var matchPlaceCondition = false
    private var matchDateCondition = false
    
    private let correctColor = UIColor(red: 0.0,
                                       green: 180.0/255.0,
                                       blue: 223.0/255.0,
                                       alpha: 1.0)
    private let systemFont = UIFont.systemFont(ofSize: 13.0)
    private let barButtonFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 17.0)
    
    private let dateFormatter = DateFormatter()
    
    @IBOutlet private var opponentTeamLabel: UILabel!
    @IBOutlet private var opponentTeamTextField: UITextField! {
        didSet { opponentTeamTextField.delegate = self }
    }
    @IBOutlet private var opponentTeamTextFieldBorder: UIView!
    private lazy var opponentTeamConditionImageView: UIImageView = {
        let opponentTeamConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        opponentTeamConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return opponentTeamConditionImageView
    }()
    
    @IBOutlet private var matchPlaceLabel: UILabel!
    @IBOutlet private var matchPlaceTextField: UITextField! {
        didSet { matchPlaceTextField.delegate = self }
    }
    @IBOutlet private var matchPlaceTextFieldBorder: UIView!
    private lazy var matchPlaceConditionImageView: UIImageView = {
        let matchPlaceConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        matchPlaceConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return matchPlaceConditionImageView
    }()
    
    @IBOutlet private var matchDateLabel: UILabel!
    @IBOutlet private var matchDateTextField: UITextField! {
        didSet { matchDateTextField.delegate = self }
    }
    @IBOutlet private var matchDateTextFieldBorder: UIView!
    private lazy var matchDateConditionImageView: UIImageView = {
        let matchDateConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        matchDateConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return matchDateConditionImageView
    }()
    
    private lazy var matchDatePicker: UIDatePicker = {
        let matchDatePicker = UIDatePicker()
        matchDatePicker.locale = Locale(identifier: "ko-KR")
        matchDatePicker.backgroundColor = .white
        matchDatePicker.minuteInterval = 5
        matchDatePicker.addTarget(self,
                                  action: #selector(matchDatePickerDidChanged(_:)),
                                  for: .valueChanged)
        
        return matchDatePicker
    }()
    private lazy var pickerToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        toolBar.sizeToFit()
        
        let matchDateDoneButton = UIBarButtonItem(title: "완료",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(matchDateDoneButtonDidTapped(_:)))
        matchDateDoneButton.setTitleTextAttributes(
            [NSAttributedStringKey.font: barButtonFont ?? systemFont],
            for: .normal)
        matchDateDoneButton.tintColor = correctColor
        let positionSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
        let matchDateCancelButton = UIBarButtonItem(title: "취소",
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(matchDateCancelButtonDidTapped(_:)))
        matchDateCancelButton.setTitleTextAttributes(
            [NSAttributedStringKey.font: barButtonFont ?? systemFont],
            for: .normal)
        matchDateCancelButton.tintColor = correctColor
        toolBar.setItems([matchDateCancelButton, positionSpaceItem, matchDateDoneButton], animated: false)
        
        return toolBar
    }()
    
    @IBOutlet private var doneButton: UIButton!
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func matchDateDoneButtonDidTapped(_ sender: UIButton) {
        matchDateTextField.resignFirstResponder()
    }
    
    @objc private func matchDateCancelButtonDidTapped(_ sender: UIButton) {
        matchDateTextField.text = nil
        matchDateFieldCondition(false)
        matchDateTextField.resignFirstResponder()
    }
    
    @objc private func matchDatePickerDidChanged(_ sender: UIDatePicker) {
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        matchDate = dateFormatter.string(from: matchDatePicker.date)
        
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: matchDatePicker.date)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: matchDatePicker.date)
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: matchDatePicker.date)
        dateFormatter.dateFormat = "a hh:mm"
        let time = dateFormatter.string(from: matchDatePicker.date)
        
        matchDateTextField.text = "\(month)월 \(day)일 \(dayOfWeek) \(time)"
        
        matchDateFieldCondition(true)
    }
    
    @IBAction func cancelButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        spinnerStartAnimating(spinner)
        if let currnetUser = Auth.auth().currentUser {
            let ref = Database.database().reference()
            
            CloudFunction.getUserDataWith(currnetUser) {
                (user, error) -> Void in
                
                if let user = user {
                    let homeScore: Int = -1
                    let opponentScore: Int = -1
                    
                    ref.child("schedules").child(user.teamCode).childByAutoId().setValue(
                        ["opponentTeam": self.opponentTeam,
                         "matchPlace": self.matchPlace,
                         "matchDate": self.matchDate,
                         "homeScore": homeScore,
                         "opponentScore": opponentScore])
                    
                    self.spinnerStopAnimating(self.spinner)
                    self.performSegue(withIdentifier: "unwindToScheduleView", sender: nil)
                }
            }
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonDisabled(doneButton)
        
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        matchDate = dateFormatter.string(from: matchDatePicker.date)
    }
}

extension ScheduleCreateViewController: UITextFieldDelegate {
    
    // MARK: Custom Methods
    
    private func textFieldConditionChecked() {
        if opponentTeamCondition, matchPlaceCondition, matchDateCondition {
            buttonEnabled(doneButton)
        } else {
            buttonDisabled(doneButton)
        }
    }
    
    private func opponentTeamTextFieldCondition(_ state: Bool) {
        if state {
            opponentTeamCondition = true
            opponentTeam = opponentTeamTextField.text ?? ""
            opponentTeamLabel.textColor = correctColor
            opponentTeamTextField.textColor = correctColor
            opponentTeamTextField.tintColor = correctColor
            opponentTeamTextFieldBorder.backgroundColor = correctColor
            
            if !opponentTeamConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(opponentTeamConditionImageView)
                self.view.addConstraints(opponentTeamConditionImageViewConstraints())
            }
        } else {
            opponentTeamCondition = false
            opponentTeam = opponentTeamTextField.text ?? ""
            opponentTeamLabel.textColor = .white
            opponentTeamTextField.textColor = .white
            opponentTeamTextField.tintColor = .white
            opponentTeamTextFieldBorder.backgroundColor = .white
            
            if opponentTeamConditionImageView.isDescendant(of: self.view) {
                opponentTeamConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    private func matchPlaceTextFieldCondition(_ state: Bool) {
        if state {
            matchPlaceCondition = true
            matchPlace = matchPlaceTextField.text ?? ""
            matchPlaceLabel.textColor = correctColor
            matchPlaceTextField.textColor = correctColor
            matchPlaceTextField.tintColor = correctColor
            matchPlaceTextFieldBorder.backgroundColor = correctColor
            
            if !matchPlaceConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(matchPlaceConditionImageView)
                self.view.addConstraints(matchPlaceConditionImageViewConstraints())
            }
        } else {
            matchPlaceCondition = false
            matchPlace = matchPlaceTextField.text ?? ""
            matchPlaceLabel.textColor = .white
            matchPlaceTextField.textColor = .white
            matchPlaceTextField.tintColor = .white
            matchPlaceTextFieldBorder.backgroundColor = .white
            
            if matchPlaceConditionImageView.isDescendant(of: self.view) {
                matchPlaceConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    // MARK: TextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        
        switch textField {
        case opponentTeamTextField:
            if textCount < 2 { opponentTeamTextFieldCondition(false) }
            else if textCount > 25 { opponentTeamTextFieldCondition(false) }
            else { opponentTeamTextFieldCondition(true) }
        case matchPlaceTextField:
            if textCount < 2 { matchPlaceTextFieldCondition(false) }
            else if textCount > 25 { matchPlaceTextFieldCondition(false) }
            else { matchPlaceTextFieldCondition(true) }
        case matchDateTextField:
            matchDateTextField.inputView = matchDatePicker
            matchDateTextField.inputAccessoryView = pickerToolBar
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.count ?? 0
        let replacementCount = currentCount + string.count - range.length
        
        switch textField {
        case opponentTeamTextField:
            if currentCount < 2 { opponentTeamTextFieldCondition(false) }
            else if currentCount > 25 { opponentTeamTextFieldCondition(false) }
            else { opponentTeamTextFieldCondition(true) }
            
            if replacementCount < 26 { return true }
            else { return false }
        case matchPlaceTextField:
            if currentCount < 2 { matchPlaceTextFieldCondition(false) }
            else if currentCount > 25 { matchPlaceTextFieldCondition(false) }
            else { matchPlaceTextFieldCondition(true) }
            
            if replacementCount < 26 { return true }
            else { return false }
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case opponentTeamTextField:
            opponentTeamTextField.resignFirstResponder()
            matchPlaceTextField.becomeFirstResponder()
        case matchPlaceTextField:
            matchPlaceTextField.resignFirstResponder()
            matchDateTextField.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        
        switch textField {
        case opponentTeamTextField:
            if textCount < 2 { opponentTeamTextFieldCondition(false) }
            else if textCount > 25 { opponentTeamTextFieldCondition(false) }
            else { opponentTeamTextFieldCondition(true) }
        case matchPlaceTextField:
            if textCount < 2 { matchPlaceTextFieldCondition(false) }
            else if textCount > 25 { matchPlaceTextFieldCondition(false) }
            else { matchPlaceTextFieldCondition(true) }
        default:
            break
        }
    }
}

extension ScheduleCreateViewController {
    private func matchDateFieldCondition(_ state: Bool) {
        if state {
            matchDateCondition = true
            matchDateLabel.textColor = correctColor
            matchDateTextField.textColor = correctColor
            matchDateTextField.tintColor = correctColor
            matchDateTextFieldBorder.backgroundColor = correctColor
            
            if !matchDateConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(matchDateConditionImageView)
                self.view.addConstraints(matchDateConditionImageViewConstraints())
            }
        } else {
            matchDateCondition = false
            matchDateLabel.textColor = .white
            matchDateTextField.textColor = .white
            matchDateTextField.tintColor = .white
            matchDateTextFieldBorder.backgroundColor = .white
            
            if matchDateConditionImageView.isDescendant(of: self.view) {
                matchDateConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
}

extension ScheduleCreateViewController {
    private func opponentTeamConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: opponentTeamConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: opponentTeamTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: opponentTeamConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: opponentTeamTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: opponentTeamConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: opponentTeamTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: opponentTeamConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: opponentTeamConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func matchPlaceConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: matchPlaceConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: matchPlaceTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: matchPlaceConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: matchPlaceTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: matchPlaceConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: matchPlaceTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: matchPlaceConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: matchPlaceConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func matchDateConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: matchDateConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: matchDateTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: matchDateConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: matchDateTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: matchDateConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: matchDateTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: matchDateConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: matchDateConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
}
