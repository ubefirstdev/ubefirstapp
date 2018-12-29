//
//  TestGoogleViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 21/10/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class TestGoogleViewController: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let googleButton=GIDSignInButton()
        googleButton.center=self.view.center
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance().uiDelegate=self

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
