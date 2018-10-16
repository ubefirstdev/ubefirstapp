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
import FirebaseAuth

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBAction func btn_LoginFacebook(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email","user_friends"], from: self)
        { (result, error) -> Void in
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
                         self?.performSegue(withIdentifier: "LoginToHome", sender: self)
                         }
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.current()==nil){
            //self.test_label.text="usuario desconectado"
        }else{
            //self.test_label.text="sesion activa"
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil{
           // self.lbl_logStatus.text = error.localizedDescription
        }else if result.isCancelled{
            //self.lbl_logStatus.text="inicio de sesion cancelado"
        } else {
            //self.lbl_logStatus.text="inicio de sesion correcto"
            
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                  //  self.lbl_logStatus.text="error con firebase"
                    return
                }
                // User is signed in
               /* self.lbl_logStatus.text="usuario conectado con firebase"
                OperationQueue.main.addOperation {
                    [weak self] in
                    self?.performSegue(withIdentifier: "GoInicialView", sender: self)
                }*/
                
                
            }
        }
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //self.lbl_logStatus.text="usuario desconectado"
    }

    
}

