//
//  TeamSettingTeamDataViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 4..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class TeamSettingTeamDataViewController: UIViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    var teamLogo: UIImage!
    var teamPhoto: UIImage!
    
    var teamPhotoIsEditing = false
    var teamLogoIsEditing = false
    var changedTeamPhoto: UIImage?
    var changedTeamLogo: UIImage?
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "팀 설정"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(
            title: "확인",
            style: .plain,
            target: self,
            action: #selector(doneButtonDidTapped(_:)))
        doneButton.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)!,
            NSAttributedStringKey.foregroundColor : UIColor.white], for: .normal)
        
        return doneButton
    }()
    
    private lazy var teamPhotoImageView: UIImageView =  {
        let teamPhotoImageView = UIImageView(image: #imageLiteral(resourceName: "backgroundMain"))
        teamPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamPhotoImageView
    }()
    
    private lazy var teamPhotoSettingImageView: UIImageView =  {
        let teamPhotoSettingImageView = UIImageView(image: #imageLiteral(resourceName: "camera"))
        teamPhotoSettingImageView.backgroundColor = .white
        teamPhotoSettingImageView.layer.borderColor =
            UIColor.black.withAlphaComponent(0.15).cgColor
        teamPhotoSettingImageView.layer.borderWidth = 1.0
        teamPhotoSettingImageView.clipsToBounds = true
        teamPhotoSettingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(teamPhotoDidTapped(_:)))
        teamPhotoSettingImageView.isUserInteractionEnabled = true
        teamPhotoSettingImageView.addGestureRecognizer(tapGesture)
        
        return teamPhotoSettingImageView
    }()
    
    private lazy var teamLogoImageView: UIImageView = {
        let teamLogoImageView = UIImageView(image: teamLogo)
        teamLogoImageView.layer.borderColor =
            UIColor.black.withAlphaComponent(0.15).cgColor
        teamLogoImageView.layer.borderWidth = 1.0
        teamLogoImageView.clipsToBounds = true
        teamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(teamLogoDidTapped(_:)))
        teamLogoImageView.isUserInteractionEnabled = true
        teamLogoImageView.addGestureRecognizer(tapGesture)
        
        return teamLogoImageView
    }()
    
    private lazy var teamLogoSettingImageView: UIImageView =  {
        let teamLogoSettingImageView = UIImageView(image: #imageLiteral(resourceName: "camera"))
        teamLogoSettingImageView.backgroundColor = .white
        teamLogoSettingImageView.layer.borderColor =
            UIColor.black.withAlphaComponent(0.15).cgColor
        teamLogoSettingImageView.layer.borderWidth = 1.0
        teamLogoSettingImageView.clipsToBounds = true
        teamLogoSettingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(teamLogoDidTapped(_:)))
        teamLogoSettingImageView.isUserInteractionEnabled = true
        teamLogoSettingImageView.addGestureRecognizer(tapGesture)
        
        return teamLogoSettingImageView
    }()
    
    private lazy var homeStadiumLabel: UILabel = {
        let homeStadiumLabel = UILabel()
        homeStadiumLabel.text = "홈 구장"
        homeStadiumLabel.textColor = .white
        homeStadiumLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        homeStadiumLabel.adjustsFontSizeToFitWidth = true
        homeStadiumLabel.minimumScaleFactor = 0.5
        homeStadiumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return homeStadiumLabel
    }()
    private lazy var homeStadiumTextField: UITextField = {
        let homeStadiumTextField = UITextField()
        homeStadiumTextField.textColor = .white
        homeStadiumTextField.tintColor = .white
        homeStadiumTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        homeStadiumTextField.adjustsFontSizeToFitWidth = true
        homeStadiumTextField.minimumFontSize = 9.0
        homeStadiumTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return homeStadiumTextField
    }()
    private lazy var homeStadiumTextFieldBorder: UIView = {
        let homeStadiumTextFieldBorder = UIView()
        homeStadiumTextFieldBorder.backgroundColor = .white
        homeStadiumTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return homeStadiumTextFieldBorder
    }()
    private lazy var homeStadiumConditionImageView: UIImageView = {
        let homeStadiumConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        homeStadiumConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return homeStadiumConditionImageView
    }()
    
    private lazy var createAtLabel: UILabel = {
        let createAtLabel = UILabel()
        createAtLabel.text = "창단 연도"
        createAtLabel.textColor = .white
        createAtLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        createAtLabel.adjustsFontSizeToFitWidth = true
        createAtLabel.minimumScaleFactor = 0.5
        createAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return createAtLabel
    }()
    private lazy var createAtTextField: UITextField = {
        let createAtTextField = UITextField()
        createAtTextField.textColor = .white
        createAtTextField.tintColor = .white
        createAtTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        createAtTextField.adjustsFontSizeToFitWidth = true
        createAtTextField.minimumFontSize = 9.0
        createAtTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return createAtTextField
    }()
    private lazy var createAtTextFieldBorder: UIView = {
        let createAtTextFieldBorder = UIView()
        createAtTextFieldBorder.backgroundColor = .white
        createAtTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return createAtTextFieldBorder
    }()
    private lazy var createAtConditionImageView: UIImageView = {
        let createAtConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        createAtConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return createAtConditionImageView
    }()
    
    private lazy var teamMemberButton: UIButton = {
        let teamMemberButton = UIButton(type: .system)
        teamMemberButton.setTitle("팀원 관리", for: .normal)
        teamMemberButton.setTitleColor(HBColor.lightGray, for: .normal)
        teamMemberButton.titleLabel?.font = UIFont(
            name: "AppleSDGothicNeo-Bold",
            size: 16.0)
        teamMemberButton.titleLabel?.adjustsFontSizeToFitWidth = true
        teamMemberButton.titleLabel?.minimumScaleFactor = 0.5
        teamMemberButton.backgroundColor = .white
        teamMemberButton.translatesAutoresizingMaskIntoConstraints = false
        
        return teamMemberButton
    }()
    
    // MARK: Methods
    
    @objc private func teamPhotoDidTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        teamPhotoIsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func teamLogoDidTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        teamLogoIsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func doneButtonDidTapped(_ sender: UIBarButtonItem) {
        if let changedTeamPhoto = changedTeamPhoto {
            
        }
        
        if let changedTeamLogo = changedTeamLogo {
            
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = HBColor.lightGray
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = doneButton
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.barTintColor = UIColor.clear
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        
        self.view.addSubview(teamPhotoImageView)
        self.view.addConstraints(teamPhotoImageViewConstraints())
        self.view.addSubview(teamLogoImageView)
        self.view.addConstraints(teamLogoImageViewConstraints())
        self.view.addSubview(teamPhotoSettingImageView)
        self.view.addConstraints(teamPhotoSettingImageViewConstraints())
        self.view.addSubview(teamLogoSettingImageView)
        self.view.addConstraints(teamLogoSettingImageViewConstraints())
        
        self.view.addSubview(homeStadiumLabel)
        self.view.addConstraints(homeStadiumLabelConstraints())
        self.view.addSubview(homeStadiumTextField)
        self.view.addConstraints(homeStadiumTextFieldConstraints())
        self.view.addSubview(homeStadiumTextFieldBorder)
        self.view.addConstraints(homeStadiumTextFieldBorderConstraints())
        self.view.addSubview(createAtLabel)
        self.view.addConstraints(createAtLabelConstraints())
        self.view.addSubview(createAtTextField)
        self.view.addConstraints(createAtTextFieldConstraints())
        self.view.addSubview(createAtTextFieldBorder)
        self.view.addConstraints(createAtTextFieldBorderConstraints())
        self.view.addSubview(teamMemberButton)
        self.view.addConstraints(teamMemberButtonConstraints())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnSwipe = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.height / 2
        teamPhotoSettingImageView.layer.cornerRadius =
            teamPhotoSettingImageView.frame.size.height / 2
        teamLogoSettingImageView.layer.cornerRadius =
            teamLogoSettingImageView.frame.size.height / 2
        teamMemberButton.layer.cornerRadius = 10.0
    }
}

// MAKR: ImagePicker Delegate
extension TeamSettingTeamDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            if teamPhotoIsEditing {
                teamPhotoImageView.image = image
                changedTeamPhoto = image
                
                teamPhotoIsEditing = false
            } else if teamLogoIsEditing {
                teamLogoImageView.image = image
                changedTeamLogo = image
                
                teamLogoIsEditing = false
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        teamPhotoIsEditing = false
        teamLogoIsEditing = false
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension TeamSettingTeamDataViewController {
    private func teamPhotoImageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .height, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .width, multiplier: 280/414, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private func teamPhotoSettingImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamPhotoSettingImageView, attribute: .centerX, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerX, multiplier: 377/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamPhotoSettingImageView, attribute: .centerY, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerY, multiplier: 250/140, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamPhotoSettingImageView, attribute: .width, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamPhotoSettingImageView, attribute: .height, relatedBy: .equal,
            toItem: teamPhotoSettingImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamLogoImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .centerX, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .centerY, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerY, multiplier: 276/140, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .width, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .width, multiplier: 120/414, constant: 1.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .height, relatedBy: .equal,
            toItem: teamLogoImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamLogoSettingImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamLogoSettingImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 253/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamLogoSettingImageView, attribute: .centerY, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerY, multiplier: 316/140, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamLogoSettingImageView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamLogoSettingImageView, attribute: .height, relatedBy: .equal,
            toItem: teamLogoSettingImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func homeStadiumLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: homeStadiumLabel, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: homeStadiumLabel, attribute: .top, relatedBy: .equal,
            toItem: teamLogoImageView, attribute: .bottom, multiplier: 1.0, constant: self.view.bounds.size.height * 32/736)
        let widthConstraint = NSLayoutConstraint(
            item: homeStadiumLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 100/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: homeStadiumLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 19/736, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func homeStadiumTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: homeStadiumTextField, attribute: .leading, relatedBy: .equal,
            toItem: homeStadiumLabel, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: homeStadiumTextField, attribute: .top, relatedBy: .equal,
            toItem: homeStadiumLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: homeStadiumTextField, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: homeStadiumTextField, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 37/736, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func homeStadiumTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: homeStadiumTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: homeStadiumTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: homeStadiumTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: homeStadiumTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: homeStadiumTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 2/736, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func createAtLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: createAtLabel, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: createAtLabel, attribute: .top, relatedBy: .equal,
            toItem: teamLogoImageView, attribute: .bottom, multiplier: 1.0, constant: self.view.bounds.size.height * 142/736)
        let widthConstraint = NSLayoutConstraint(
            item: createAtLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 100/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: createAtLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 19/736, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func createAtTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: createAtTextField, attribute: .leading, relatedBy: .equal,
            toItem: createAtLabel, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: createAtTextField, attribute: .top, relatedBy: .equal,
            toItem: createAtLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: createAtTextField, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: createAtTextField, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 37/736, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func createAtTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: createAtTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: createAtTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: createAtTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: createAtTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: createAtTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 2/736, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamMemberButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamMemberButton, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: teamMemberButton, attribute: .top, relatedBy: .equal,
            toItem: teamLogoImageView, attribute: .bottom, multiplier: 1.0, constant: self.view.bounds.size.height * 255/736)
        let widthConstraint = NSLayoutConstraint(
            item: teamMemberButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamMemberButton, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 60/736, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
}