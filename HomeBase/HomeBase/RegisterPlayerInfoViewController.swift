//
//  RegisterPlayerInfoViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 7..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class RegisterPlayerInfoViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var position: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var pitcher: UISegmentedControl!
    @IBOutlet weak var hitter: UISegmentedControl!
    @IBOutlet weak var done: UIButton!
    
    let positionData = [String](arrayLiteral: "선발투수", "중간계투", "마무리투수", "포수", "1루수", "2루수", "3루수", "유격수", "좌익수", "중견수", "우익수", "지명타자")
    
    private var positionText: String = ""
    private var numberText: Int = 0
    private var pitcherText: String = ""
    private var hitterText: String = ""
    
    // MARK: Action
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        position.inputView = pickerView
        
        textFieldDidBeginEditing(position)
        
        let pitcherSegmentedControl = UISegmentedControl(items: ["좌", "우"])
        pitcherSegmentedControl.selectedSegmentIndex = 1
        
        let hitterSegmentedControl = UISegmentedControl(items: ["좌", "우"])
        hitterSegmentedControl.selectedSegmentIndex = 1
    }
    
    // MARK: Function
    func pickerViewToolBar(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RegisterPlayerInfoViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegisterPlayerInfoViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    // MARK: BarButton
    @objc func doneClick() {
        position.resignFirstResponder()
    }
    
    @objc func cancelClick() {
        position.text = nil
        position.resignFirstResponder()
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

extension RegisterPlayerInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return positionData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return positionData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        position.text = positionData[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerViewToolBar(position)
    }
}
