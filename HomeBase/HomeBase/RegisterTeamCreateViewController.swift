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
    
    private var currentOriginY:CGFloat = 0.0
    
    private var teamLogo: UIImage = UIImage()
    private var isTeamLogoChanged: Bool = false
    private var teamName: String = ""
    private var teamIntro: String = ""
    
    private var teamNameCondition = false
    private var teamIntroCondition = false
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "팀 등록"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    @IBOutlet private weak var teamLogoImageView: UIImageView!
    
    @IBOutlet private weak var teamNameLabel: UILabel!
    @IBOutlet private weak var teamNameTextField: UITextField!
    @IBOutlet private weak var teamNameTextFieldBorder: UIView!
    private lazy var teamNameConditionImageView: UIImageView = {
        let teamNameConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        teamNameConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamNameConditionImageView
    }()
    
    @IBOutlet private weak var teamIntroLabel: UILabel!
    @IBOutlet private weak var teamIntroBaseView: UIView!
    @IBOutlet private weak var teamIntroTextView: UITextView!
    
    private lazy var accessoryView: UIView = {
        let accessoryViewFrame = CGRect(
            x: 0.0,
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
        doneButton.titleLabel?.font = UIFont(
            name: "AppleSDGothicNeo-Bold",
            size: 18.0)
        doneButton.addTarget(
            self,
            action: #selector(doneButtonDidTapped(_:)),
            for: .touchUpInside)
        doneButton.backgroundColor = HBColor.darkGray
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        return doneButton
    }()
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
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
            let logoRef = storageRef.child(teamCode).child("teamLogo")
            logoRef.putData(logoData)
            
            guard let currentUser = Auth.auth().currentUser else { return }
            let admin: String = currentUser.uid
            var provider: String = ""
            for profile in currentUser.providerData {
                provider = profile.providerID
            }
            
            if provider == "password" {
                databaseRef.child("users").child(currentUser.uid).updateChildValues(
                    ["teamCode": teamCode])
            } else {
                databaseRef.child("users").child(currentUser.uid).setValue(
                    ["teamCode": teamCode])
            }
            
            databaseRef.child("teams").child(teamCode).setValue(
                ["name": teamName,
                 "logo": logoRef.fullPath,
                 "description": teamIntro,
                 "admin": admin])
            
            guard let registerTeamCompleteViewController =
                self.storyboard?.instantiateViewController(
                    withIdentifier: "RegisterTeamCompleteViewController")
                    as? RegisterTeamCompleteViewController else { return }
                
            registerTeamCompleteViewController.teamLogo = teamLogo
            registerTeamCompleteViewController.teamName = self.teamName
            registerTeamCompleteViewController.teamCode = teamCode
            spinnerStopAnimating(spinner)
            
            self.navigationController?.pushViewController(
                registerTeamCompleteViewController,
                animated: true)
        } else {
            spinnerStopAnimating(spinner)
            print("UIImage to Data error")
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        doneButton.removeFromSuperview()
        accessoryView.addSubview(doneButton)
        accessoryView.addConstraints(doneButtonKeyboardConstraints())

        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height + accessoryView.frame.size.height
            
            self.view.frame.origin.y = currentOriginY
            
            if teamNameTextField.isFirstResponder {
                let bottomLocationOfNextView = bottomLocationOf(teamIntroBaseView)
                if bottomLocationOfNextView < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOfNextView
                            - keyboardHeight)
                }
            } else if teamIntroTextView.isFirstResponder {
                if bottomLocationOf(teamIntroTextView) < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOf(teamIntroTextView)
                            - keyboardHeight)
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification:NSNotification) {
        doneButton.removeFromSuperview()
        self.view.addSubview(doneButton)
        doneButtonConstraints()
        
        self.view.frame.origin.y = currentOriginY
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        teamIntroTextView.text = "우리는 우주 최강 사회인 야구팀, 홈베이스이다. 다 덤벼라 얍!"
        teamIntroTextView.textColor = .lightGray
        teamIntroTextView.inputAccessoryView = accessoryView
        
        self.view.addSubview(doneButton)
        doneButtonConstraints()
        buttonDisabled(doneButton)
        
        teamNameTextField.delegate = self
        teamIntroTextView.delegate = self
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        currentOriginY = self.view.frame.origin.y
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.height / 2.0
        teamLogoImageView.layer.borderColor = HBColor.lightGray.cgColor
        teamLogoImageView.layer.borderWidth = 1.0
        
        teamIntroBaseView.layer.borderWidth = 1.0
        teamIntroBaseView.layer.borderColor = UIColor.white.cgColor
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
        if teamNameCondition, teamIntroCondition {
            buttonEnabled(doneButton)
        } else {
            buttonDisabled(doneButton)
        }
    }
    
    private func teamNameTextFieldCondition(_ state: Bool) {
        if state {
            teamNameCondition = true
            teamName = teamNameTextField.text ?? "default"
            teamNameLabel.textColor = HBColor.correct
            teamNameTextField.textColor = HBColor.correct
            teamNameTextField.tintColor = HBColor.correct
            teamNameTextFieldBorder.backgroundColor = HBColor.correct
            
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
    
    // MARK: TextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        
        switch textField {
        case teamNameTextField:
            if textCount < 2 { teamNameTextFieldCondition(false) }
            else if textCount > 25 { teamNameTextFieldCondition(false) }
            else { teamNameTextFieldCondition(true) }
            
            teamNameTextField.inputAccessoryView = accessoryView
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
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        
        switch textField {
        case teamNameTextField:
            if textCount < 2 { teamNameTextFieldCondition(false) }
            else if textCount > 25 { teamNameTextFieldCondition(false) }
            else { teamNameTextFieldCondition(true) }
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
            teamIntroLabel.textColor = HBColor.correct
            teamIntroBaseView.layer.borderColor = HBColor.correct.cgColor
            teamIntroTextView.textColor = HBColor.correct
            teamIntroTextView.tintColor = HBColor.correct
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
        let leadingConstraint = NSLayoutConstraint(
            item: teamNameConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: teamNameTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamNameConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: teamNameTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamNameConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: teamNameConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func doneButtonConstraints() {
        if #available(iOS 11, *) {
            let guide = self.view.safeAreaLayoutGuide
            doneButton.topAnchor.constraint(
                equalTo: guide.bottomAnchor, constant: -45.0).isActive = true
            doneButton.leadingAnchor.constraint(
                equalTo: guide.leadingAnchor, constant: 0.0).isActive = true
            doneButton.trailingAnchor.constraint(
                equalTo: guide.trailingAnchor, constant: 0.0).isActive = true
            doneButton.bottomAnchor.constraint(
                equalTo: guide.bottomAnchor, constant: 0.0).isActive = true
        } else {
            let guide = self.bottomLayoutGuide
            doneButton.topAnchor.constraint(
                equalTo: guide.bottomAnchor, constant: -45.0).isActive = true
            doneButton.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
            doneButton.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
            doneButton.bottomAnchor.constraint(
                equalTo: guide.bottomAnchor, constant: 0.0).isActive = true
        }
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
