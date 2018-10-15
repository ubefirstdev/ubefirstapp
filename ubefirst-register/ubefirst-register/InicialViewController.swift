//
//  InicialViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 15/10/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class InicialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if FBSDKAccessToken.current() != nil{
            //sesion activa
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "InicialToHome", sender: self)
            }
            
        }else{
            //ninguna sesion
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "InicialToLogin", sender: self)
            }
        }
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
