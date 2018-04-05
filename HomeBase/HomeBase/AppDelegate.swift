//
//  AppDelegate.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 2..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        FBSDKApplicationDelegate.sharedInstance().application(
            application,
            didFinishLaunchingWithOptions: launchOptions)
        
        if let currentUser = Auth.auth().currentUser {
            CloudFunction.getPlayerDataWith(currentUser) {
                (playerData, error) -> Void in
                
                MainViewController.progressView.animate(value: 0.25)
                if let _ = playerData {
                    CloudFunction.getUserDataWith(currentUser) {
                        (userData, error) -> Void in
                        
                        MainViewController.progressView.animate(value: 0.5)
                        if let userData = userData {
                            CloudFunction.getTeamDataWith(userData.teamCode) {
                                (teamData, error) -> Void in
                                
                                MainViewController.progressView.animate(value: 0.75)
                                if let teamData = teamData {
                                    let storageRef = Storage.storage().reference()
                                    let imageRef = storageRef.child(teamData.logo)
                                    
                                    MainViewController.progressView.animate(value: 1.0)
                                    imageRef.getData(maxSize: 4 * 1024 * 1024) {
                                        (data, error) in
                                        
                                        if let error = error {
                                            print(error)
                                        } else {
                                            let mainStoryboard = UIStoryboard(
                                                name: "Main",
                                                bundle: nil)
                                            
                                            guard let mainTabBarController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else { return }
                                                
                                            mainTabBarController.teamData = teamData
                                            mainTabBarController.teamLogo = UIImage(data: data!) ?? #imageLiteral(resourceName: "team_logo")
                                            UIApplication.shared.keyWindow?.rootViewController = mainTabBarController
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    MainViewController.progressView.animate(value: 1.0)
                    
                    let startStoryBoard = UIStoryboard(name: "Start", bundle: nil)
                    let signInViewController = startStoryBoard.instantiateInitialViewController()
                    
                    self.window?.rootViewController = signInViewController
                }
            }
        } else {
            MainViewController.progressView.animate(value: 1.0)
            
            let startStoryBoard = UIStoryboard(name: "Start", bundle: nil)
            let signInViewController = startStoryBoard.instantiateInitialViewController()
            
            self.window?.rootViewController = signInViewController
        }
        
        return true
    }

    // MARK: Social Sign in

    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {

        let googleHandled = GIDSignIn.sharedInstance().handle(
            url,
            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
            annotation: [:])
        
        let facebookHandled = FBSDKApplicationDelegate.sharedInstance().application(
            app,
            open: url,
            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplicationOpenURLOptionsKey.annotation] as Any)
        
        return (googleHandled || facebookHandled)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {

        let googleHandled = GIDSignIn.sharedInstance().handle(
            url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        let facebookHandled = FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        return (googleHandled || facebookHandled)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
