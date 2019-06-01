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

var invitacionBusqueda: [invitacionData] = []

class ConfiguracionViewController: UIViewController {
    
    @IBAction func btn_invitacionesPressed(_ sender: Any) {
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
                    let status = document.data()["status"] as? String
                    let idInvitacion = document.data()["idInvitacion"] as? String
                    let hijosCompartidosNombres = document.data()["hijos_compartidos_nombre"] as? [String]
                    invitacionBusqueda.append(invitacionData.init(nombre: nombre, correo: correo, nHijos: nHijos, suscripcion: suscripcion, uid: uid, status:status, idInvitacion:idInvitacion, hijosCompartidosNombres: hijosCompartidosNombres!))
                    
                }
                alertController.dismiss(animated: false, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //funcion callback despues de 0.4 segundos
                    invitacionSegue = true
                    self.performSegue(withIdentifier: "ConfiguracionToInvitaciones", sender: nil)
                }
                
                
            }
            
        }
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
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "login")
        
        self.dismiss(animated: true) { () -> Void in
            //Perform segue or push some view with your code
            UIApplication.shared.keyWindow?.rootViewController = newViewController
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
