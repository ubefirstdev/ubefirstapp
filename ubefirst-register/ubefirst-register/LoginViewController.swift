//
//  ViewController.swift
//  ubefirst-register
//
//  Created by MariaJose De la Fuente on 11/10/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBAction func btn_FacebookLogin(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email","user_friends"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    //inicio de sesion cancelado
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    //inicio de sesion correcto
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    
                    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                        if let error = error {
                            //inicio de sesion con error al conectar con firebase
                            return
                        }
                        // User is signed in
                        //inicio de sesion correcto con firebase
                        OperationQueue.main.addOperation {
                            [weak self] in
                            self?.performSegue(withIdentifier: "LoginToInicial", sender: self)
                        }
                    }
                }
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

