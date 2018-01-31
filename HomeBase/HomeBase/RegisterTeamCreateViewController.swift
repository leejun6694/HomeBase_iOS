//
//  RegisterTeamCreateViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 10..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RegisterTeamCreateViewController: UIViewController {

    // MARK: Properties
    
    private var teamLogo: UIImage = UIImage()
    private var isTeamLogoChanged:Bool = false
    private var teamName:String = ""
    private var teamIntro:String = ""
    private var teamHome:String = ""
    
    private var teamNameCondition = false
    private var teamIntroCondition = false
    private var teamHomeCondition = false
    
    private let correctColor = UIColor(red: 0.0,
                                       green: 180.0/255.0,
                                       blue: 223.0/255.0,
                                       alpha: 1.0)
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "팀 등록"
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
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    @IBOutlet private weak var teamLogoImageView: UIImageView!
    
    @IBOutlet private weak var teamNameLabel: UILabel!
    @IBOutlet private weak var teamNameTextField: UITextField! {
        didSet { teamNameTextField.delegate = self }
    }
    @IBOutlet private weak var teamNameTextFieldBorder: UIView!
    private lazy var teamNameConditionImageView: UIImageView = {
        let teamNameConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        teamNameConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamNameConditionImageView
    }()
    
    @IBOutlet private weak var teamIntroLabel: UILabel!
    @IBOutlet private weak var teamIntroBaseView: UIView! {
        didSet {
            teamIntroBaseView.layer.borderWidth = 1.0
            teamIntroBaseView.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet private weak var teamIntroTextView: UITextView! {
        didSet { teamIntroTextView.delegate = self }
    }
    
    @IBOutlet private weak var teamHomeLabel: UILabel!
    @IBOutlet private weak var teamHomeTextField: UITextField! {
        didSet { teamHomeTextField.delegate = self }
    }
    @IBOutlet private weak var teamHomeTextFieldBorder: UIView!
    private lazy var teamHomeConditionImageView: UIImageView = {
        let teamHomeConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        teamHomeConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamHomeConditionImageView
    }()
    
    // MARK: Methods
    
    @IBAction private func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction private func teamLogoDidTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func doneButtonDidTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        spinnerStartAnimating(spinner)
        
        let databaseRef = Database.database().reference()
        let teamCode = databaseRef.child("teams").childByAutoId().key
        
        let storageRef = Storage.storage().reference()
        if isTeamLogoChanged == false {
            teamLogo = #imageLiteral(resourceName: "team_logo")
        }
        if let logoData = UIImagePNGRepresentation(teamLogo) {
            let logoRef = storageRef.child(teamCode).child("teamLogo.png")
            logoRef.putData(logoData)
            
            if let currentUser = Auth.auth().currentUser {
                var provider:String = ""
                for profile in currentUser.providerData {
                    provider = profile.providerID
                }
                let hasTeam:Bool = true
                
                if provider == "password" {
                    databaseRef.child("users").child(currentUser.uid).updateChildValues(
                        ["hasTeam": hasTeam])
                } else {
                    databaseRef.child("users").child(currentUser.uid).setValue(
                        ["hasTeam": hasTeam])
                }
                
                databaseRef.child("teams").child(teamCode).setValue(
                    ["name": teamName,
                     "logo": logoRef.fullPath,
                     "description": teamIntro,
                     "homeStadium": teamHome,
                     "admin": currentUser.uid,
                     "members": currentUser.uid])
            }
            
            if let registerTeamCompleteViewController =
                self.storyboard?.instantiateViewController(withIdentifier: "RegisterTeamCompleteViewController") as? RegisterTeamCompleteViewController {
                
                registerTeamCompleteViewController.teamName = self.teamName
                registerTeamCompleteViewController.teamCode = teamCode
                spinnerStopAnimating(spinner)
                self.navigationController?.pushViewController(registerTeamCompleteViewController, animated: true)
            }
        } else {
            spinnerStopAnimating(spinner)
            print("UIImage to Data error")
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        doneButton.removeFromSuperview()
        accessoryView.addSubview(doneButton)
        accessoryView.addConstraints(doneButtonKeyboardConstraints())

        if teamNameTextField.isFirstResponder {
            self.view.frame.origin.y -= 100.0
        } else {
            self.view.frame.origin.y -= 140.0
        }
    }
    
    @objc private func keyboardWillHide(_ notification:NSNotification) {
        doneButton.removeFromSuperview()
        self.view.addSubview(doneButton)
        self.view.addConstraints(doneButtonConstraints())
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        var navigationBarHeight: CGFloat = 0.0
        if let navigation = self.navigationController {
            navigationBarHeight = navigation.navigationBar.frame.height
        }
        self.view.frame.origin.y = statusBarHeight + navigationBarHeight
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        teamIntroTextView.text = "우리는 우주 최강 사회인 야구팀, 홈베이스이다. 다 덤벼라 얍!"
        teamIntroTextView.textColor = .lightGray
        teamIntroTextView.inputAccessoryView = accessoryView
        
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.height / 2.0
    }
}

extension RegisterTeamCreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            teamLogo = image
            isTeamLogoChanged = true
            teamLogoImageView.image = teamLogo
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension RegisterTeamCreateViewController: UITextFieldDelegate {
    
    // MARK: Custom Methods
    
    private func textFieldConditionChecked() {
        if teamNameCondition, teamIntroCondition, teamHomeCondition {
            buttonEnabled(doneButton)
        } else {
            buttonDisabled(doneButton)
        }
    }
    
    private func teamNameTextFieldCondition(_ state: Bool) {
        if state {
            teamNameCondition = true
            teamName = teamNameTextField.text ?? "default"
            teamNameLabel.textColor = correctColor
            teamNameTextField.textColor = correctColor
            teamNameTextField.tintColor = correctColor
            teamNameTextFieldBorder.backgroundColor = correctColor
            
            if !teamNameConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(teamNameConditionImageView)
                self.view.addConstraints(teamNameConditionImageViewConstraints())
            }
        } else {
            teamNameCondition = false
            teamNameLabel.textColor = .white
            teamNameTextField.textColor = .white
            teamNameTextField.tintColor = .white
            teamNameTextFieldBorder.backgroundColor = .white
            
            if teamNameConditionImageView.isDescendant(of: self.view) {
                teamNameConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    private func teamHomeTextFieldCondition(_ state: Bool) {
        if state {
            teamHomeCondition = true
            teamHome = teamHomeTextField.text ?? "default"
            teamHomeLabel.textColor = correctColor
            teamHomeTextField.textColor = correctColor
            teamHomeTextField.tintColor = correctColor
            teamHomeTextFieldBorder.backgroundColor = correctColor
            
            if !teamHomeConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(teamHomeConditionImageView)
                self.view.addConstraints(teamHomeConditionImageViewConstraints())
            }
        } else {
            teamHomeCondition = false
            teamHomeLabel.textColor = .white
            teamHomeTextField.textColor = .white
            teamHomeTextField.tintColor = .white
            teamHomeTextFieldBorder.backgroundColor = .white
            
            if teamHomeConditionImageView.isDescendant(of: self.view) {
                teamHomeConditionImageView.removeFromSuperview()
            }
        }
        textFieldConditionChecked()
    }
    
    // MARK: TextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        
        switch textField {
        case teamNameTextField:
            if textCount < 2 { teamNameTextFieldCondition(false) }
            else if textCount > 25 { teamNameTextFieldCondition(false) }
            else { teamNameTextFieldCondition(true) }
            
            teamNameTextField.inputAccessoryView = accessoryView
        case teamHomeTextField:
            if textCount < 2 { teamHomeTextFieldCondition(false) }
            else if textCount > 25 { teamHomeTextFieldCondition(false) }
            else { teamHomeTextFieldCondition(true) }
            
            teamHomeTextField.inputAccessoryView = accessoryView
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.count ?? 0
        let replacementCount = currentCount + string.count - range.length
        
        switch textField {
        case teamNameTextField:
            if currentCount < 2 { teamNameTextFieldCondition(false) }
            else if currentCount > 25 { teamNameTextFieldCondition(false) }
            else { teamNameTextFieldCondition(true) }
            
            if replacementCount < 26 { return true }
            else { return false }
        case teamHomeTextField:
            if currentCount < 2 { teamHomeTextFieldCondition(false) }
            else if currentCount > 25 { teamHomeTextFieldCondition(false) }
            else { teamHomeTextFieldCondition(true) }
            
            if replacementCount < 26 { return true }
            else { return false }
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case teamNameTextField:
            teamNameTextField.resignFirstResponder()
            teamIntroTextView.becomeFirstResponder()
            
            return false
        case teamHomeTextField:
            teamHomeTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        
        switch textField {
        case teamNameTextField:
            if textCount < 2 { teamNameTextFieldCondition(false) }
            else if textCount > 25 { teamNameTextFieldCondition(false) }
            else { teamNameTextFieldCondition(true) }
        case teamHomeTextField:
            if textCount < 2 { teamHomeTextFieldCondition(false) }
            else if textCount > 25 { teamHomeTextFieldCondition(false) }
            else { teamHomeTextFieldCondition(true) }
        default:
            break
        }
    }
}

extension RegisterTeamCreateViewController: UITextViewDelegate {
    
    // MARK: Custom Methods
    
    private func teamIntroTextViewCondition(_ state: Bool) {
        if state {
            teamIntroCondition = true
            teamIntro = teamIntroTextView.text ?? "default"
            teamIntroLabel.textColor = correctColor
            teamIntroBaseView.layer.borderColor = correctColor.cgColor
            teamIntroTextView.textColor = correctColor
            teamIntroTextView.tintColor = correctColor
        } else {
            teamIntroCondition = false
            teamIntroLabel.textColor = .white
            teamIntroBaseView.layer.borderColor = UIColor.white.cgColor
            teamIntroTextView.textColor = .lightGray
            teamIntroTextView.tintColor = .white
        }
        textFieldConditionChecked()
    }
    
    // MARK: TextView Delegates
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            teamIntroTextViewCondition(false)
        } else {
            teamIntroTextViewCondition(true)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCount = textView.text.count
        let replacementCount = currentCount + text.count - range.length
        
        if replacementCount < 1 { teamIntroTextViewCondition(false) }
        else { teamIntroTextViewCondition(true) }
        
        if replacementCount < 51 { return true }
        else { return false }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "우리는 우주 최강 사회인 야구팀, 홈베이스이다. 다 덤벼라 얍!"
            teamIntroTextViewCondition(false)
        } else {
            teamIntroTextViewCondition(true)
        }
        self.view.endEditing(true)
    }
}

extension RegisterTeamCreateViewController {
    private func teamNameConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: teamNameConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: teamNameTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: teamNameConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: teamNameTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamNameConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: teamNameTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamNameConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: teamNameTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
        return [centerYConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamHomeConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: teamHomeConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: teamHomeTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: teamHomeConditionImageView, attribute: .trailing, relatedBy: .equal,
            toItem: teamHomeTextField, attribute: .trailing, multiplier: 335.0/345.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamHomeConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: teamHomeTextField, attribute: .width, multiplier: 20.0/345.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamHomeConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: teamHomeTextField, attribute: .height, multiplier: 18.0/35.0, constant: 0.0)
        
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
