//
//  ConfiguracionViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 15/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit
import SwiftyDropbox
import FBSDKLoginKit
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

class ConfiguracionViewController: UIViewController {
    
    
    @IBAction func btnPressed_informacionUsuario(_ sender: Any) {
    }
    
    @IBAction func btnPressed_hijos(_ sender: Any) {
    }
    
    @IBAction func btnPressed_dimensiones(_ sender: Any) {
    }
    
    @IBAction func btnPresssed_cuentaDropbox(_ sender: Any) {
    DropboxClientsManager.authorizeFromController(UIApplication.shared,controller: self,openURL: {
            (url: URL) -> Void in UIApplication.shared.openURL(url)
        })
    }
    
    @IBAction func btnPressed_avisoDePrivacidad(_ sender: Any) {
    }
    
    @IBAction func btnPressed_conocenos(_ sender: Any) {
    }
    
    @IBAction func btnPressed_comoUsarUbefirst(_ sender: Any) {
    }
    
    @IBAction func btnPressed_cambiatePremium(_ sender: Any) {
    }
    
    @IBAction func btnPressed_cerrarSesion(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        FBSDKAccessToken.setCurrent(nil)
        UserDefaults.standard.removeObject(forKey: "accessTokenUID")
        GIDSignIn.sharedInstance().signOut()
        userData = Padre()
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "ConfiguracionToLogin", sender: self)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
