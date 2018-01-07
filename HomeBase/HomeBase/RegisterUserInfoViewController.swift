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
    
    var year = 0
    var month = 0
    var day = 0
    
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
    
    @IBOutlet private weak var weightTextField: UITextField! {
        didSet {
            bottomBorderWith(weightTextField)
            weightTextField.delegate = self
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                nameConditionLabel.text = "이름은 2자 이상이여야 합니다"
                self.view.addSubview(nameConditionLabel)
            } else if nameTextCount > 10 {
                nameConditionLabel.text = "이름은 10자 이하여야 합니다"
                self.view.addSubview(nameConditionLabel)
            }
        case birthTextField:
            if let birthText = birthTextField.text {
                if birthText.count != 12 {
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
                        self.view.addSubview(birthConditionLabel)
                    } else {
                        switch month {
                        case 1, 3, 5, 7, 8, 10, 12:
                            if day > 31 {
                                self.view.addSubview(birthConditionLabel)
                            }
                        case 4, 6, 9, 11:
                            if day > 30 {
                                self.view.addSubview(birthConditionLabel)
                            }
                        case 2:
                            if day > 29 {
                                self.view.addSubview(birthConditionLabel)
                            }
                        default:
                            self.view.addSubview(birthConditionLabel)
                        }
                    }
                }
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
            }
            
            if replacementCount <= 12 { return true }
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            if nameConditionLabel.isDescendant(of: self.view) {
                nameConditionLabel.removeFromSuperview()
            }
        case birthTextField:
            if birthConditionLabel.isDescendant(of: self.view) {
                birthConditionLabel.removeFromSuperview()
            }
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldCondition(textField)
    }
}
