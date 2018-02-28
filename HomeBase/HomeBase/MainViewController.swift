//
//  MainViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 28..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: Properties
    
    static var progressView = UIProgressView()
    
    // MARK: Methods
    
    private func drawProgressView() {
        MainViewController.progressView.setProgress(0.01, animated: false)
        MainViewController.progressView.tintColor = UIColor(red: 0.0,
                                                            green: 180.0/255.0,
                                                            blue: 233.0/255.0,
                                                            alpha: 1.0)
        MainViewController.progressView.trackTintColor = UIColor.clear
        MainViewController.progressView.layer.cornerRadius = 7.0
        MainViewController.progressView.clipsToBounds = true
        MainViewController.progressView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawProgressView()
        self.view.addSubview(MainViewController.progressView)
        self.view.addConstraints(progressViewConstraints())
        
//        MainViewController.progressView.transform = CGAffineTransform(scaleX: 1, y: 8)
        
    }
}

extension MainViewController {
    private func progressViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: MainViewController.progressView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: MainViewController.progressView, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 1.8, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: MainViewController.progressView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 0.7, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: MainViewController.progressView, attribute: .height, relatedBy: .equal,
            toItem: MainViewController.progressView, attribute: .width, multiplier: 0.05, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}

extension UIProgressView {
    func animate(value: Float) {
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveLinear,
                       animations: { self.setProgress(value, animated: true) },
                       completion: nil)
    }
}
