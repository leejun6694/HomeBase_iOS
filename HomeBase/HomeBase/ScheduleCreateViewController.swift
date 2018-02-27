//
//  ScheduleCreateViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 27..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleCreateViewController: UIViewController {

    // MARK: Properties
    
    private let correctColor = UIColor(red: 0.0,
                                       green: 180.0/255.0,
                                       blue: 223.0/255.0,
                                       alpha: 1.0)
    private let systemFont = UIFont.systemFont(ofSize: 13.0)
    private let barButtonFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 17.0)
    
    @IBOutlet private var opponentTeamLabel: UILabel!
    @IBOutlet private var opponentTeamTextField: UITextField! {
        didSet { opponentTeamTextField.delegate = self }
    }
    
    @IBOutlet private var matchPlaceLabel: UILabel!
    @IBOutlet private var matchPlaceTextField: UITextField! {
        didSet { matchPlaceTextField.delegate = self }
    }
    
    @IBOutlet private var matchDateLabel: UILabel!
    @IBOutlet private var matchDateTextField: UITextField! {
        didSet { matchDateTextField.delegate = self }
    }
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
    
    // MARK: Methods
    
    @objc private func matchDateDoneButtonDidTapped(_ sender: UIButton) {
        matchDateTextField.resignFirstResponder()
    }
    
    @objc private func matchDateCancelButtonDidTapped(_ sender: UIButton) {
        matchDateTextField.text = nil
        matchDateTextField.resignFirstResponder()
    }
    
    @objc private func matchDatePickerDidChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: matchDatePicker.date)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: matchDatePicker.date)
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: matchDatePicker.date)
        dateFormatter.dateFormat = "a hh:mm"
        let time = dateFormatter.string(from: matchDatePicker.date)
        
        matchDateTextField.text = "\(month)월 \(day)일 \(dayOfWeek) \(time)"
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension ScheduleCreateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
//        case opponentTeamTextField:
//        case matchPlaceTextField:
        case matchDateTextField:
            matchDateTextField.inputView = matchDatePicker
            matchDateTextField.inputAccessoryView = pickerToolBar
        default: break
        }
    }
}
