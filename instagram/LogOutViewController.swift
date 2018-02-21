//
//  LogOutViewController.swift
//  instagram
//
//  Created by Thalia Villalobos on 2/21/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func userLogOut(_ sender: AnyObject) {
        
        //self.performSegue(withIdentifier: "backToLogin", sender: nil)
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    
    }
    
}
