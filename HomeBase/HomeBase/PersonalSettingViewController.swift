//
//  PersonalSettingViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 25..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class PersonalSettingViewController: UIViewController {
    
    // MARK: Properties
    
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
    
    // MARK: Methods
    
    @objc private func backButtonDidTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
        
        self.view.addSubview(buttonUnderView)
        self.view.addConstraints(userButtonUnderViewConstraints())
    }
    
    @objc private func playerButtonDidTapped(_ sender: UIButton) {
        userButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        playerButton.setTitleColor(.white, for: .normal)
        
        if buttonUnderView.isDescendant(of: self.view) {
            buttonUnderView.removeFromSuperview()
        }
        
        self.view.addSubview(buttonUnderView)
        self.view.addConstraints(playerButtonUnderViewConstraints())
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
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = HBColor.lightGray
        
        self.view.addSubview(backButton)
        self.view.addConstraints(backButtonConstraints())
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
}
