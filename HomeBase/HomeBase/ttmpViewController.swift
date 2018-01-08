//
//  ttmpViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 8..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ttmpViewController: UIViewController {

    @IBAction func tmpButtonDidTapped(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserInfoViewController")
        self.navigationController?.pushViewController(nextVC!, animated: true)
        
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
