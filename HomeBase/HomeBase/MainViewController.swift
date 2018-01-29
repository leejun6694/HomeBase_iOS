//
//  MainViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 17..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
