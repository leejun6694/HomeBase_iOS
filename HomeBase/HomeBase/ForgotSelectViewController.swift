//
//  ForgotSelectViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 15..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ForgotSelectViewController: UIViewController {

    // MARK: Methods
    
    @IBAction private func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancelButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction private func emailButtonDidTapped(_ sender: UIButton) {
        if let forgotEmailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotEmailViewController") as? ForgotEmailViewController {
            
            self.navigationController?.pushViewController(forgotEmailViewController, animated: false)
        }
    }
    
    @IBAction private func pwButtonDidTapped(_ sender: UIButton) {
        if let forgotPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
            
            self.navigationController?.pushViewController(forgotPasswordViewController, animated: false)
        }
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
}
