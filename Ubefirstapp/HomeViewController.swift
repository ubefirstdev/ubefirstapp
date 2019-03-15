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
import SideMenu

var imagenRecuerdoBuffer = UIImage()
var segueSender = ""

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lbl_username: UILabel!
    @IBOutlet weak var btn_configuracion: UIButton!
    @IBOutlet weak var btn_mejoresMomentos: UIButton!
    
    
    @IBAction func btnPressed_configuracion(_ sender: Any) {
        /*if (userData.premium==false){
         let alertController = UIAlertController(title: "Funcionalidad limitada", message: "Obtenga una cuenta ubefirst Premium para gestionar hijos, dimensiones y más.", preferredStyle: UIAlertController.Style.alert)
         alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
         UIAlertAction in
         })
         self.present(alertController, animated: true, completion: nil)
         } else {

         }
        
        //Aqui se logea con Dropbox de manera provicional
        /*DropboxClientsManager.authorizeFromController(UIApplication.shared,controller: self,openURL: {
            (url: URL) -> Void in UIApplication.shared.openURL(url)
        })*/
*/    }
    
    @IBAction func btnPressed_mejoresMomentos(_ sender: Any) {
        if (userData.premium==false){
            NSLog("Hola")
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
        SideMenuManager.default.menuFadeStatusBar = false
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuWidth = 320
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
