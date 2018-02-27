//
//  MainTabBarController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 6..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class MainTabBarController: UITabBarController {
    
    // MARK: Properties
    
    var teamData: HBTeam!
    var teamLogo: UIImage!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
}
