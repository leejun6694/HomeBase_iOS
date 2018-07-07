//
//  PersonalSettingViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 25..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PersonalSettingViewController: UIViewController {
    
    // MARK: Properties
    
    var userData: HBUser!
    var playerData: HBPlayer!
    
    private var currentOriginY: CGFloat = 0.0
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backButton.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(
            self,
            action: #selector(backButtonDidTapped(_:)),
            for: .touchUpInside)
        
        return backButton
    }()
    
    private lazy var doneButton: UIButton = {
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("완료", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.titleLabel?.font = UIFont(
            name: "AppleSDGothicNeo-Bold",
            size: 17.0)
        doneButton.addTarget(
            self,
            action: #selector(doneButtonDidTapped(_:)),
            for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        return doneButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "내 설정"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var personalPhotoImageView: UIImageView = {
        let personalPhotoImageView = UIImageView(image: #imageLiteral(resourceName: "personal_default"))
        personalPhotoImageView.layer.borderColor =
            UIColor.black.withAlphaComponent(0.15).cgColor
        personalPhotoImageView.layer.borderWidth = 1.0
        personalPhotoImageView.clipsToBounds = true
        personalPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(personalPhotoDidTapped(_:)))
        personalPhotoImageView.isUserInteractionEnabled = true
        personalPhotoImageView.addGestureRecognizer(tapGesture)
        
        return personalPhotoImageView
    }()
    
    private lazy var personalPhotoSettingImageView: UIImageView =  {
        let personalPhotoSettingImageView = UIImageView(image: #imageLiteral(resourceName: "camera"))
        personalPhotoSettingImageView.backgroundColor = .white
        personalPhotoSettingImageView.layer.borderColor =
            UIColor.black.withAlphaComponent(0.15).cgColor
        personalPhotoSettingImageView.layer.borderWidth = 1.0
        personalPhotoSettingImageView.clipsToBounds = true
        personalPhotoSettingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(personalPhotoDidTapped(_:)))
        personalPhotoSettingImageView.isUserInteractionEnabled = true
        personalPhotoSettingImageView.addGestureRecognizer(tapGesture)
        
        return personalPhotoSettingImageView
    }()
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
    }()
    
    private lazy var userButton: UIButton = {
        let userButton = UIButton(type: .system)
        userButton.setTitle("기본정보", for: .normal)
        userButton.setTitleColor(.white, for: .normal)
        userButton.titleLabel?.font = UIFont(
            name: "AppleSDGothicNeo-Bold",
            size: 17.0)
        userButton.titleLabel?.adjustsFontSizeToFitWidth = true
        userButton.titleLabel?.minimumScaleFactor = 0.5
        userButton.backgroundColor = UIColor.clear
        userButton.translatesAutoresizingMaskIntoConstraints = false
        
        userButton.addTarget(
            self,
            action: #selector(userButtonDidTapped(_:)),
            for: .touchUpInside)
        
        return userButton
    }()
    
    private lazy var playerButton: UIButton = {
        let playerButton = UIButton(type: .system)
        playerButton.setTitle("선수정보", for: .normal)
        playerButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        playerButton.titleLabel?.font = UIFont(
            name: "AppleSDGothicNeo-Bold",
            size: 17.0)
        playerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        playerButton.titleLabel?.minimumScaleFactor = 0.5
        playerButton.backgroundColor = UIColor.clear
        playerButton.translatesAutoresizingMaskIntoConstraints = false
        
        playerButton.addTarget(
            self,
            action: #selector(playerButtonDidTapped(_:)),
            for: .touchUpInside)
        
        return playerButton
    }()
    
    private lazy var buttonUnderView: UIView = {
        let buttonUnderView = UIView()
        buttonUnderView.backgroundColor = .white
        buttonUnderView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonUnderView
    }()
    
    private lazy var userView: PersonalSettingUserView = {
        let userView = PersonalSettingUserView()
        userView.dbName = userData.name
        userView.dbBirth = userData.birth
        userView.dbHeight = playerData.height
        userView.dbWeight = playerData.weight
        userView.translatesAutoresizingMaskIntoConstraints = false
        
        return userView
    }()
    
    private lazy var playerView: PersonalSettingPlayerView = {
        let playerView = PersonalSettingPlayerView()
        playerView.dbPosition = playerData.position
        playerView.dbPlayerNumber = playerData.backNumber
        playerView.dbPitcher = playerData.pitchPosition
        playerView.dbHitter = playerData.batPosition
        
        playerView.position = playerData.position
        playerView.playerNumber = playerData.backNumber
        playerView.pitcher = playerData.pitchPosition
        playerView.hitter = playerData.batPosition
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        return playerView
    }()
    
    @IBOutlet private var signOutButton: UIButton!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func backButtonDidTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneButtonDidTapped(_ sender: UIButton) {
        if userView.userCondition, playerView.playerCondition {
            spinnerStartAnimating(spinner)
            
            guard let mainTabBarController =
                self.presentingViewController as? MainTabBarController else { return }
            
            var batPosition = "우"
            let hitterControlValue = playerView.hitterControl.selectedSegmentIndex
            if hitterControlValue == 0 { batPosition = "좌" }
            else { batPosition = "우" }
            
            var pitchPosition = "우"
            let pitcherControlValue = playerView.pitcherControl.selectedSegmentIndex
            if pitcherControlValue == 0 { pitchPosition = "좌" }
            else { pitchPosition = "우" }
            
            let databaseRef = Database.database().reference()
            if let currentUser = Auth.auth().currentUser {
                let userRef = databaseRef.child("users").child(currentUser.uid)
                let playerRef = databaseRef.child("players").child(currentUser.uid)
                
                userRef.updateChildValues(
                    ["name": userView.name,
                     "birth": userView.birth]) {
                        (error, ref) in
                    
                        CloudFunction.getUserDataWith(currentUser) {
                            (userData, error) in
                                                
                            if let _ = error {
                                return
                            } else {
                                mainTabBarController.userData = userData
                                                    
                                playerRef.updateChildValues(
                                    ["name": self.userView.name,
                                     "height": self.userView.height,
                                     "weight": self.userView.weight,
                                     "position": self.playerView.position,
                                     "backNumber": self.playerView.playerNumber,
                                     "pitchPosition": pitchPosition,
                                     "batPosition": batPosition]) {
                                        (error, ref) in
                                        
                                        CloudFunction.getPlayerDataWith(currentUser) {
                                            (playerData, error) in
                                                                                        
                                            if let _ = error {
                                                return
                                            } else {
                                                mainTabBarController.playerData = playerData
                                                
                                                self.spinnerStopAnimating(self.spinner)
                                                self.dismiss(animated: true, completion: nil)
                                            }
                                        }
                                }
                            }
                        }
                }
            }
        } else {
            guard let personalSettingErrorViewController =
                self.storyboard?.instantiateViewController(
                    withIdentifier: "PersonalSettingErrorViewController")
                    as? PersonalSettingErrorViewController else { return }
            
            personalSettingErrorViewController.modalPresentationStyle = .overCurrentContext
            self.present(personalSettingErrorViewController, animated: false, completion: nil)
        }
    }
    
    @objc private func personalPhotoDidTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func userButtonDidTapped(_ sender: UIButton) {
        playerButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        userButton.setTitleColor(.white, for: .normal)
        
        if buttonUnderView.isDescendant(of: self.view) {
            buttonUnderView.removeFromSuperview()
        }
        
        if playerView.isDescendant(of: self.view) {
            playerView.removeFromSuperview()
        }
        
        self.view.addSubview(buttonUnderView)
        self.view.addConstraints(userButtonUnderViewConstraints())
        
        self.view.addSubview(userView)
        self.view.addConstraints(userViewConstraints())
    }
    
    @objc private func playerButtonDidTapped(_ sender: UIButton) {
        userButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        playerButton.setTitleColor(.white, for: .normal)
        
        if buttonUnderView.isDescendant(of: self.view) {
            buttonUnderView.removeFromSuperview()
        }
        
        if userView.isDescendant(of: self.view) {
            userView.removeFromSuperview()
        }
        
        self.view.addSubview(buttonUnderView)
        self.view.addConstraints(playerButtonUnderViewConstraints())
        
        self.view.addSubview(playerView)
        self.view.addConstraints(playerViewConstraints())
    }
    
    @IBAction func signOutButtonDidTapped(_ sender: UIButton) {
        if let user = Auth.auth().currentUser {
            do {
                print("sign out: \(user.email ?? "default")")
                try Auth.auth().signOut()
                
                let storyBoard = UIStoryboard(name: "Start", bundle: nil)
                let signInViewController = storyBoard.instantiateInitialViewController()
                
                UIApplication.shared.keyWindow?.rootViewController = signInViewController
            } catch {
                print(error)
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.view.frame.origin.y = currentOriginY
            
            if userView.nameTextField.isFirstResponder {
                if bottomLocationOf(userView.weightTextField) - 295.0 < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOf(userView.weightTextField)
                            - 290.0
                            - keyboardHeight)
                }
            } else if userView.birthTextField.isFirstResponder {
                if bottomLocationOf(userView.weightTextField) - 295.0 < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOf(userView.weightTextField)
                            - 290.0
                            - keyboardHeight)
                }
            } else if userView.heightTextField.isFirstResponder {
                if bottomLocationOf(userView.weightTextField) - 295.0 < keyboardHeight {
                    self.view.frame.origin.y -= keyboardHeight
                }
            } else if userView.weightTextField.isFirstResponder {
                if bottomLocationOf(userView.weightTextField) - 295.0 < keyboardHeight {
                    self.view.frame.origin.y -= keyboardHeight
                }
            }
            
            if playerView.positionTextField.isFirstResponder {
                    self.view.frame.origin.y -= keyboardHeight
            } else if playerView.playerNumberTextField.isFirstResponder {
                self.view.frame.origin.y -= keyboardHeight
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification:NSNotification) {
        self.view.frame.origin.y = currentOriginY
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = HBColor.lightGray
        
        self.view.addSubview(backButton)
        self.view.addConstraints(backButtonConstraints())
        self.view.addSubview(doneButton)
        self.view.addConstraints(doneButtonConstraints())
        self.view.addSubview(titleLabel)
        self.view.addConstraints(titleLabelConstraints())
        
        self.view.addSubview(personalPhotoImageView)
        self.view.addConstraints(personalPhotoImageViewConstraints())
        self.view.addSubview(personalPhotoSettingImageView)
        self.view.addConstraints(personalPhotoSettingImageViewConstraints())
        self.view.addSubview(divisionView)
        self.view.addConstraints(divisionViewConstraints())
        self.view.addSubview(userButton)
        self.view.addConstraints(userButtonConstraints())
        self.view.addSubview(playerButton)
        self.view.addConstraints(playerButtonConstraints())
        self.view.addSubview(buttonUnderView)
        self.view.addConstraints(userButtonUnderViewConstraints())
        self.view.addSubview(userView)
        self.view.addConstraints(userViewConstraints())
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        personalPhotoImageView.layer.cornerRadius =
            personalPhotoImageView.frame.size.height / 2
        personalPhotoSettingImageView.layer.cornerRadius =
            personalPhotoSettingImageView.frame.size.height / 2
    }
}

extension PersonalSettingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            personalPhotoImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PersonalSettingViewController {
    private func backButtonConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: backButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: backButton, attribute: .top, relatedBy: .equal,
            toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 9.0)
        let heightConstraint = NSLayoutConstraint(
            item: backButton, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 40/736, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: backButton, attribute: .width, relatedBy: .equal,
            toItem: backButton, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func doneButtonConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 360/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .centerY, relatedBy: .equal,
            toItem: backButton, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 30/736, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .centerY, relatedBy: .equal,
            toItem: backButton, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 100/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 40/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func personalPhotoImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: personalPhotoImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: personalPhotoImageView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 101/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: personalPhotoImageView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 106/414, constant: 1.0)
        let heightConstraint = NSLayoutConstraint(
            item: personalPhotoImageView, attribute: .height, relatedBy: .equal,
            toItem: personalPhotoImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func personalPhotoSettingImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: personalPhotoSettingImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 253/207, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: personalPhotoSettingImageView, attribute: .bottom, relatedBy: .equal,
            toItem: personalPhotoImageView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: personalPhotoSettingImageView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: personalPhotoSettingImageView, attribute: .height, relatedBy: .equal,
            toItem: personalPhotoSettingImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, bottomConstraint, widthConstraint, heightConstraint]
    }
    
    private func divisionViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 290/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 3/736, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func userButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: userButton, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 134.5/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: userButton, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 262/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: userButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 70/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: userButton, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 20/736, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func playerButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: playerButton, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 264.5/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: playerButton, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 262/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 70/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerButton, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 20/736, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func userButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: userButton, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: divisionView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 70/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: divisionView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func playerButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: playerButton, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: divisionView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 70/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: divisionView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func userViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: userView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: userView, attribute: .top, relatedBy: .equal,
            toItem: divisionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: userView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: userView, attribute: .bottom, relatedBy: .equal,
            toItem: signOutButton, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, bottomConstraint]
    }
    
    private func playerViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: playerView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: playerView, attribute: .top, relatedBy: .equal,
            toItem: divisionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: playerView, attribute: .bottom, relatedBy: .equal,
            toItem: signOutButton, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, bottomConstraint]
    }
}
