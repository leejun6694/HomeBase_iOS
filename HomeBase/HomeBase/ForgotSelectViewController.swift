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
        guard let forgotEmailViewController =
            self.storyboard?.instantiateViewController(
            withIdentifier: "ForgotEmailViewController")
                as? ForgotEmailViewController else { return }
            
        self.navigationController?.pushViewController(
            forgotEmailViewController,
            animated: false)
    }
    
    @IBAction private func pwButtonDidTapped(_ sender: UIButton) {
        guard let forgotPasswordViewController =
            self.storyboard?.instantiateViewController(
            withIdentifier: "ForgotPasswordViewController")
                as? ForgotPasswordViewController else { return }
            
            self.navigationController?.pushViewController(
                forgotPasswordViewController,
                animated: false)
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
