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
    
    var teamName:String = ""
    var teamCode:String = ""
    var teamLogoImage:UIImage = UIImage()
    
    @IBOutlet private var teamLogoImageView: UIImageView!
    @IBOutlet private var teamNameLabel: UILabel!
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction private func doneButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        let databaseRef = Database.database().reference()
        
        if let currentUser = Auth.auth().currentUser {
            let member = currentUser.uid
            
            databaseRef.child("users").child(currentUser.uid).updateChildValues(
                ["teamCode": teamCode])
            databaseRef.child("teams").child(teamCode).child(
                "members").childByAutoId().setValue(member)
            
            if let registerUserNavigation = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserNavigation") as? RegisterUserNavigation {
                
                spinnerStopAnimating(spinner)
                self.present(registerUserNavigation, animated: true, completion: nil)
            }
        }
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
        teamLogoImageView.layer.borderColor = UIColor(red: 44.0/255.0,
                                                      green: 44.0/255.0,
                                                      blue: 44.0/255.0,
                                                      alpha: 1.0).cgColor
        teamLogoImageView.layer.borderWidth = 1.0
    }
}
