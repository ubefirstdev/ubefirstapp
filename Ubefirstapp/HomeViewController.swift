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
    @IBOutlet weak var btn_configuracion: UIButton!
    @IBOutlet weak var btn_mejoresMomentos: UIButton!
    @IBOutlet weak var lbl_mejoresMomentos: UILabel!
    
    
    @IBAction func btnPressed_configuracion(_ sender: Any) {
        if (userData.premium==false){
            let alertController = UIAlertController(title: "Funcionalidad limitada", message: "Obtenga una cuenta ubefirst Premium para gestionar hijos, dimensiones y más.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
            })
            self.present(alertController, animated: true, completion: nil)
        } else {
            
        }
    }
    
    @IBAction func btnPressed_mejoresMomentos(_ sender: Any) {
        if (userData.premium==false){
            let alertController = UIAlertController(title: "Funcionalidad limitada", message: "Obtenga una cuenta ubefirst Premium para acceder al resumen de los mejores momentos", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
            })
            self.present(alertController, animated: true, completion: nil)
        }else{
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "HomeToMejoresMomentos", sender: self)
            }
        }
    }
    
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
        UserDefaults.standard.removeObject(forKey: "accessTokenUID")
        GIDSignIn.sharedInstance().signOut()
        userData = Padre()
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "HomeToLogin", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (userData.premium==true){
            self.lbl_username.text=self.lbl_username.text! + "\n" + userData.nombre
            if (userData.colaborador==true){
                self.btn_configuracion.isHidden = true
                self.lbl_username.text = self.lbl_username.text! + "\n(Colaborador)"
            }

        } else {
            self.lbl_username.font = UIFont(name:self.lbl_username.font.fontName,size: 16)
            self.lbl_username.text="Cuenta gratuita"
            self.lbl_username.textColor = UIColor.red
        }
      
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
