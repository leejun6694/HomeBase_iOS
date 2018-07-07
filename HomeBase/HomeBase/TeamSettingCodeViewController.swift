//
//  TeamSettingCodeViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 7. 8..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class TeamSettingCodeViewController: UIViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    var teamCode = "0"
    
    @IBOutlet private var teamNameLabel: UILabel!
    @IBOutlet private var teamCodeLabel: UILabel!
    @IBOutlet private var copyButton: UIButton!
    
    // MARK: Methods
    
    @IBAction private func cancelButtonDidTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func copyButtonDidTapped(_ sender: UIButton) {
        UIPasteboard.general.string = teamCode
        
        guard let teamSettingCodeCompleteViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "TeamSettingCodeCompleteViewController")
                as? TeamSettingCodeCompleteViewController else { return }
        
        teamSettingCodeCompleteViewController.modalPresentationStyle = .overCurrentContext
        self.present(
            teamSettingCodeCompleteViewController,
            animated: false,
            completion: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
        copyButton.addTarget(
            self,
            action: #selector(copyButtonDidTapped(_:)),
            for: .touchUpInside)
        
        teamNameLabel.text = "\(teamData.name)의 팀 코드는"
        teamCodeLabel.text = "\(teamCode)"
    }
    
    override func viewDidLayoutSubviews() {
        copyButton.layer.borderWidth = 2.0
        copyButton.layer.borderColor = HBColor.lightGray.cgColor
    }
}
