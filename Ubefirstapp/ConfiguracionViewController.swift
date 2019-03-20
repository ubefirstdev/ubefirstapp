//
//  ConfiguracionViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 15/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

var invitacionBusqueda: [colaboradorBusqueda] = []

class ConfiguracionViewController: UIViewController {
    
    @IBOutlet weak var btn_cambiatePremium: UIButton!
    
    @IBAction func btn_invitacionesColaboracion(_ sender: Any) {
        let alertController = UIAlertController(title: "Buscando invitaciones", message: "Un momento porfavor", preferredStyle: UIAlertController.Style.alert)
        let alertController1 = UIAlertController(title: "Ninguna invitación", message: "No se han encontrado invitaciones a su cuenta", preferredStyle:UIAlertController.Style.alert)
        alertController1.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { UIAlertAction in
            alertController1.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
        
        db.collection("users").document(userData.uid).collection("invitaciones").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if ((querySnapshot?.isEmpty)!){
                //ninguna invitacion
                alertController.dismiss(animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { //funcion callback despues de 0.4 segundos
                    self.present(alertController1, animated: true, completion: nil)
                }
                
            }else {
                //invitacion existente
                invitacionBusqueda = []
                for document in querySnapshot!.documents {
                    let uid = document.data()["uid"] as? String
                    let nombre = document.data()["nombre"] as? String
                    let correo = document.data()["correo"] as? String
                    let nHijos = document.data()["nhijos"] as? Int
                    let suscripcion = document.data()["suscripcion"] as? Bool
                     invitacionBusqueda.append(colaboradorBusqueda.init(nombre: nombre, correo: correo, nHijos: nHijos, suscripcion: suscripcion, uid: uid))

                }
                alertController.dismiss(animated: false, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //funcion callback despues de 0.4 segundos
                    invitacionSegue = true
                    self.performSegue(withIdentifier: "ConfiguracionToInvitaciones", sender: nil)
                }
                
                
            }
            
        }
    }
        
    
    @IBAction func btnPressed_informacionUsuario(_ sender: Any) {
    }
    
    @IBAction func btnPressed_hijos(_ sender: Any) {
    }
    
    @IBAction func btnPresssed_cuentaDropbox(_ sender: Any) {
    /*DropboxClientsManager.authorizeFromController(UIApplication.shared,controller: self,openURL: {
            (url: URL) -> Void in UIApplication.shared.openURL(url)
        })*/
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
        if (userData.premium == true){
            self.btn_cambiatePremium.isHidden = true
        }
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
