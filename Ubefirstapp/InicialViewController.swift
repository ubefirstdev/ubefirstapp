//
//  InicialViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 15/10/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import GoogleSignIn

//variables globales

class InicialViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        if FBSDKAccessToken.current() != nil{
            //sesion activa
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "InicialToLoadingPage", sender: self)
            }
            
        }else{
            //ninguna sesion
            
            //sesion con google
            if GIDSignIn.sharedInstance().hasAuthInKeychain() {
                //sesion activa con google
                OperationQueue.main.addOperation {
                    [weak self] in
                    self?.performSegue(withIdentifier: "InicialToLoadingPage", sender: self)
                }
            } else {
                //ninguna sesion de google y facebook
                if (UserDefaults.standard.string(forKey: "accessTokenUID") != nil){
                    OperationQueue.main.addOperation {
                        [weak self] in
                        self?.performSegue(withIdentifier: "InicialToLoadingPage", sender: self)
                    }
                } else {
                    //ninguna sesion con google, facebook y correo
                    OperationQueue.main.addOperation {
                        [weak self] in
                        self?.performSegue(withIdentifier: "InicialToLogin", sender: self)
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    //self.lbl_logStatus.text="error con firebase"
                    return
                }
                // User is signed in
                //self.lbl_logStatus.text="usuario conectado con firebase"
                /*OperationQueue.main.addOperation {
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
