//
//  RegisterTeamJoinEnterViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 2..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RegisterTeamJoinEnterViewController: UIViewController {
    
    // MARK: Properties
    
    var teamName: String = ""
    var teamCode: String = ""
    var teamLogoImage:UIImage = UIImage()
    
    @IBOutlet private var teamLogoImageView: UIImageView!
    @IBOutlet private var teamNameLabel: UILabel!
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction private func doneButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        let databaseRef = Database.database().reference()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        databaseRef.child("users").child(currentUser.uid).updateChildValues(
            ["teamCode": teamCode])
            
        guard let registerUserNavigation =
            self.storyboard?.instantiateViewController(
                withIdentifier: "RegisterUserNavigation")
                as? RegisterUserNavigation else { return }
            
        registerUserNavigation.teamCode = teamCode
        spinnerStopAnimating(spinner)
        
        UIApplication.shared.keyWindow?.rootViewController = registerUserNavigation
    }
    
    @IBAction func cancelButtonDidTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
       
        teamLogoImageView.image = teamLogoImage
        teamNameLabel.text = "\(teamName) 팀으로\n 입장하시겠습니까?"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.height / 2
        teamLogoImageView.layer.borderColor = HBColor.lightGray.cgColor
        teamLogoImageView.layer.borderWidth = 1.0
    }
}
