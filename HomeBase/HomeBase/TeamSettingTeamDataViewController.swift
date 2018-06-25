//
//  TeamSettingTeamDataViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 4..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class TeamSettingTeamDataViewController: UIViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    var teamLogo: UIImage!
    var teamPhoto: UIImage!
    
    private var teamPhotoIsEditing = false
    private var teamLogoIsEditing = false
    private var homeStadiumCondition = false
    private var createdAtCondition = false
    private var changedTeamPhoto: UIImage?
    private var changedTeamLogo: UIImage?
    private var homeStadium = "default"
    private var createdAt = 0
    
    private var currentOriginY: CGFloat = 0.0
    
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
        let teamPhotoImageView = UIImageView(image: teamPhoto)
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
        homeStadiumTextField.delegate = self
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
    
    private lazy var createdAtLabel: UILabel = {
        let createdAtLabel = UILabel()
        createdAtLabel.text = "창단 연도"
        createdAtLabel.textColor = .white
        createdAtLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        createdAtLabel.adjustsFontSizeToFitWidth = true
        createdAtLabel.minimumScaleFactor = 0.5
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return createdAtLabel
    }()
    private lazy var createdAtTextField: UITextField = {
        let createdAtTextField = UITextField()
        createdAtTextField.textColor = .white
        createdAtTextField.tintColor = .white
        createdAtTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        createdAtTextField.adjustsFontSizeToFitWidth = true
        createdAtTextField.minimumFontSize = 9.0
        createdAtTextField.delegate = self
        createdAtTextField.translatesAutoresizingMaskIntoConstraints = false
        createdAtTextField.keyboardType = .numberPad
        
        return createdAtTextField
    }()
    private lazy var createdAtTextFieldBorder: UIView = {
        let createdAtTextFieldBorder = UIView()
        createdAtTextFieldBorder.backgroundColor = .white
        createdAtTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return createdAtTextFieldBorder
    }()
    private lazy var createdAtConditionImageView: UIImageView = {
        let createdAtConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        createdAtConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return createdAtConditionImageView
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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
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
        viewDisabled(self.view)
        spinnerStartAnimating(spinner)
        
        if let currentUser = Auth.auth().currentUser {
            CloudFunction.getUserDataWith(currentUser) {
                (userData, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let userData = userData else { return }
                guard let mainTabBarController =
                    self.tabBarController as? MainTabBarController else { return }
                
//                let databaseRef = Database.database().reference()
//                let teamRef = databaseRef.child("teams").child(userData.teamCode)
                let storageRef = Storage.storage().reference()
                
                if let changedTeamPhoto = self.changedTeamPhoto {
                    if let photoData = UIImagePNGRepresentation(changedTeamPhoto) {
                        let photoRef = storageRef.child(userData.teamCode).child("teamPhoto")
                        
                        photoRef.putData(photoData)
                        mainTabBarController.teamPhoto = changedTeamPhoto
                    }
                }
                
                if let changedTeamLogo = self.changedTeamLogo {
                    if let logoData = UIImagePNGRepresentation(changedTeamLogo) {
                        let logoRef = storageRef.child(userData.teamCode).child("teamLogo")
                        
                        logoRef.putData(logoData)
                        mainTabBarController.teamLogo = changedTeamLogo
                    }
                }
                
                self.viewEnabled(self.view)
                self.spinnerStopAnimating(self.spinner)
                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.view.frame.origin.y = currentOriginY
            
            if homeStadiumTextField.isFirstResponder {
                if bottomLocationOf(createdAtTextFieldBorder) < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOf(createdAtTextFieldBorder)
                            - keyboardHeight)
                }
            } else if createdAtTextField.isFirstResponder {
                if bottomLocationOf(createdAtTextFieldBorder) < keyboardHeight {
                    self.view.frame.origin.y += (
                        bottomLocationOf(createdAtTextFieldBorder)
                            - keyboardHeight)
                }
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
        self.view.addSubview(createdAtLabel)
        self.view.addConstraints(createdAtLabelConstraints())
        self.view.addSubview(createdAtTextField)
        self.view.addConstraints(createdAtTextFieldConstraints())
        self.view.addSubview(createdAtTextFieldBorder)
        self.view.addConstraints(createdAtTextFieldBorderConstraints())
        self.view.addSubview(teamMemberButton)
        self.view.addConstraints(teamMemberButtonConstraints())
        
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
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnSwipe = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        currentOriginY = self.view.frame.origin.y
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

// MARK: TextField Delegate
extension TeamSettingTeamDataViewController: UITextFieldDelegate {
    private func homeStadiumTextFieldCondition(_ state: Bool) {
        if state {
            homeStadiumCondition = true
            homeStadium = homeStadiumTextField.text ?? "default"
            homeStadiumLabel.textColor = HBColor.correct
            homeStadiumTextField.textColor = HBColor.correct
            homeStadiumTextField.tintColor = HBColor.correct
            homeStadiumTextFieldBorder.backgroundColor = HBColor.correct
            
            if !homeStadiumConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(homeStadiumConditionImageView)
                self.view.addConstraints(homeStadiumConditionImageViewConstraints())
            }
        } else {
            homeStadiumCondition = false
            homeStadium = homeStadiumTextField.text ?? "default"
            homeStadiumLabel.textColor = .white
            homeStadiumTextField.textColor = .white
            homeStadiumTextField.tintColor = .white
            homeStadiumTextFieldBorder.backgroundColor = .white
            
            if homeStadiumConditionImageView.isDescendant(of: self.view) {
                homeStadiumConditionImageView.removeFromSuperview()
            }
        }
    }
    
    private func createdAtTextFieldCondition(_ state: Bool) {
        if state {
            createdAtCondition = true
            createdAt = Int(createdAtTextField.text!) ?? 0
            createdAtLabel.textColor = HBColor.correct
            createdAtTextField.textColor = HBColor.correct
            createdAtTextField.tintColor = HBColor.correct
            createdAtTextFieldBorder.backgroundColor = HBColor.correct
            
            if !createdAtConditionImageView.isDescendant(of: self.view) {
                self.view.addSubview(createdAtConditionImageView)
                self.view.addConstraints(createdAtConditionImageViewConstraints())
            }
        } else {
            createdAtCondition = false
            createdAt = Int(createdAtTextField.text!) ?? 0
            createdAtLabel.textColor = .white
            createdAtTextField.textColor = .white
            createdAtTextField.tintColor = .white
            createdAtTextFieldBorder.backgroundColor = .white
            
            if createdAtConditionImageView.isDescendant(of: self.view) {
                createdAtConditionImageView.removeFromSuperview()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.count ?? 0
        let replacementCount = currentCount + string.count - range.length
        
        switch textField {
        case homeStadiumTextField:
            if replacementCount > 0 {
                homeStadiumTextFieldCondition(true)
            } else {
                homeStadiumTextFieldCondition(false)
            }
        case createdAtTextField:
            if replacementCount == 4 {
                createdAtTextFieldCondition(true)
            } else if replacementCount < 4 {
                createdAtTextFieldCondition(false)
            } else {
                return false
            }
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case homeStadiumTextField:
            createdAtTextField.becomeFirstResponder()
        case createdAtTextField:
            self.view.endEditing(true)
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        
        switch textField {
        case homeStadiumTextField:
            if textCount > 0 {
                homeStadiumTextFieldCondition(true)
            } else {
                homeStadiumTextFieldCondition(false)
            }
        case createdAtTextField:
            if textCount == 4 {
                createdAtTextFieldCondition(true)
            } else if textCount < 4 {
                createdAtTextFieldCondition(false)
            }
        default:
            break
        }
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
    
    private func homeStadiumConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: homeStadiumConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: homeStadiumTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: homeStadiumConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: homeStadiumTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: homeStadiumConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: homeStadiumTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: homeStadiumConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: homeStadiumConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func createdAtLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: createdAtLabel, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: createdAtLabel, attribute: .top, relatedBy: .equal,
            toItem: teamLogoImageView, attribute: .bottom, multiplier: 1.0, constant: self.view.bounds.size.height * 142/736)
        let widthConstraint = NSLayoutConstraint(
            item: createdAtLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 100/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: createdAtLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 19/736, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func createdAtTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: createdAtTextField, attribute: .leading, relatedBy: .equal,
            toItem: createdAtLabel, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: createdAtTextField, attribute: .top, relatedBy: .equal,
            toItem: createdAtLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: createdAtTextField, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: createdAtTextField, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 37/736, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func createdAtTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: createdAtTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: createdAtTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: createdAtTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: createdAtTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: createdAtTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 2/736, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func createdAtConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: createdAtConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: createdAtTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: createdAtConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: createdAtTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: createdAtConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: createdAtTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: createdAtConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: createdAtConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
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
