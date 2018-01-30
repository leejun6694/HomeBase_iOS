//
//  RegisterTeamCreateViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 10..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class RegisterTeamCreateViewController: UIViewController {

    // MARK: Properties
    
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
//        doneButton.addTarget(self, action: #selector(doneButtonDidTapped(_:)), for: .touchUpInside)
        doneButton.backgroundColor = UIColor(red: 75.0/255.0,
                                             green: 75.0/255.0,
                                             blue: 75.0/255.0,
                                             alpha: 1.0)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        return doneButton
    }()
    
    @IBOutlet private var teamLogoImageView: UIImageView!
    
    @IBOutlet private var teamNameLabel: UILabel!
    @IBOutlet private var teamNameTextField: UITextField!
    @IBOutlet private var teamNameTextFieldBorder: UIView!
    
    @IBOutlet private var teamIntroLabel: UILabel!
    @IBOutlet private var teamIntroBaseView: UIView! {
        didSet {
            teamIntroBaseView.layer.borderWidth = 1.0
            teamIntroBaseView.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet private var teamIntroTextView: UITextView!
    
    @IBOutlet private var teamHomeLabel: UILabel!
    @IBOutlet private var teamHomeTextField: UITextField!
    @IBOutlet private var teamHomeTextFieldBorder: UIView!
    
    // MARK: Methods
    
//    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
//        if let registerUserInfoViewController =
//            self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserInfoViewController") as? RegisterUserInfoViewController {
//
//            self.navigationController?.pushViewController(registerUserInfoViewController, animated: true)
//        }
//    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}
