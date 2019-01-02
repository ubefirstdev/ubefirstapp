//
//  HomeViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 15/10/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

var imagenRecuerdoBuffer = UIImage()
var segueSender = ""

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lbl_username: UILabel!
    @IBOutlet weak var imageUserPicture: UIImageView!
    @IBOutlet weak var lbl_UID: UILabel!
    
    @IBAction func button_addPhoto(_ sender: Any) {
        segueSender = "HomeToAgregarRecuerdo"
        CameraHandler.shared.showActionSheet(vc: self)
    }
    
    @IBAction func btn_pressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        FBSDKAccessToken.setCurrent(nil)
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "HomeToLogin", sender: self)
        }
        
        GIDSignIn.sharedInstance().signOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_username.text="se ha cargado completamente el usuario " + userData.nombre + " de firestore"
      
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
