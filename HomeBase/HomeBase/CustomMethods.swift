//
//  CustomMethods.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 12..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

extension UIViewController {
    
    // MARK: View
    
    func viewEnabled(_ view: UIView) {
        view.alpha = 1.0
        view.isUserInteractionEnabled = true
        
        self.navigationController?.view.alpha = 1.0
    }
    
    func viewDisabled(_ view: UIView) {
        view.alpha = 0.5
        view.isUserInteractionEnabled = false
        
        self.navigationController?.view.alpha = 0.5
    }
    
    // MARK: UIButton
    
    func buttonEnabled(_ button: UIButton) {
        button.alpha = 1.0
        button.isEnabled = true
    }
    
    func buttonDisabled(_ button: UIButton) {
        button.alpha = 0.5
        button.isEnabled = false
    }
    
    // MARK: Spinner
    
    func spinnerStartAnimating(_ spinner: UIActivityIndicatorView) {
        self.view.isUserInteractionEnabled = false
        spinner.startAnimating()
    }
    
    func spinnerStopAnimating(_ spinner: UIActivityIndicatorView) {
        self.view.isUserInteractionEnabled = true
        spinner.stopAnimating()
    }
    
    // MARK: Location
    
    func bottomLocationOf(_ view: UIView) -> CGFloat {
        var bottomLocation:CGFloat = 0.0
        let viewFrameY = view.frame.origin.y
        let viewFrameHeight = view.frame.size.height
        bottomLocation = self.view.frame.height - (viewFrameY + viewFrameHeight)
        
        return bottomLocation
    }
    
    // MARK: Auth
    
    func signOutCurrentUser() {
        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
            } catch {
                print("sign out error")
            }
        }
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
    }
}
