//
//  ScheduleDeleteViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 7..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ScheduleDeleteViewController: UIViewController {

    // MARK: Properties
    
    var sid: String!
    @IBOutlet weak var deleteView: UIView!
    
    // MARK: Methods
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        if let currnetUser = Auth.auth().currentUser {
            let ref = Database.database().reference()
            
            CloudFunction.getUserDataWith(currnetUser) {
                (user, error) -> Void in
                
                if let user = user {
                    let scheduleRef = ref.child("schedules").child(user.teamCode)
                    scheduleRef.child(self.sid).removeValue()
                    
                    self.performSegue(withIdentifier: "unwindToScheduleView", sender: nil)
                }
            }
        }
    }
    
    @IBAction func cancelButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
}
