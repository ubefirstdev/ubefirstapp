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

let db = Firestore.firestore()
var userUID: String!
var userData = Padre()
var database=GetFirestoreDatabase()


class HomeViewController: UIViewController {
    
    @IBOutlet weak var lbl_username: UILabel!
    @IBOutlet weak var imageUserPicture: UIImageView!
    @IBOutlet weak var lbl_UID: UILabel!
    
    
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
        let user = Auth.auth().currentUser
        userUID=user?.uid
        database.loadDataHijos()
        database.loadDataPadre()
        /*if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            self.lbl_UID.text = user.uid
            self.lbl_username.text=user.displayName
            let docRef = Firestore.firestore().collection("hijos").document("o1rnYjHywxh6WqtBHIro")
            docRef.getDocument{(document, error) in
                if let document = document, document.exists{
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                }else{
                    print("Document do not exist")
                }
            }
            
            let photo=user.photoURL
            let data=NSData(contentsOf: photo!)
            self.imageUserPicture.image=UIImage(data: data! as Data)
            navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(named: "Boton Ajustes.png"), style: .plain, target: self, action: Selector(("addFav")))
            // ...
        }*/
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
