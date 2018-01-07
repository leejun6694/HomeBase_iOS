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
    
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet {
            bottomBorderWith(nameTextField)
            nameTextField.delegate = self
        }
    }
    @IBOutlet private var nameConditionLabel: UILabel! {
        didSet {
            nameConditionLabel.text = "글자 수는 2 - 10자여야 합니다"
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
            if nameTextCount < 2 || nameTextCount > 10 {
                self.view.addSubview(nameConditionLabel)
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
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldCondition(textField)
    }
}
