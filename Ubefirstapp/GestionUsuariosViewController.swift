//
//  GestionUsuariosViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 16/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit

class GestionUsuariosViewController: UIViewController {

    @IBOutlet weak var lbl_edicionActiva: UILabel!
    @IBOutlet weak var textLbl_nombre: UITextField!
    @IBOutlet weak var textLbl_correo: UITextField!
    @IBOutlet weak var textLbl_tipoDeCuenta: UITextField!
    @IBOutlet weak var textLbl_colaborador: UITextField!
    @IBOutlet weak var textLbl_uid: UITextField!
    @IBOutlet weak var btn_editarOutlet: UIBarButtonItem!
    
    
    @IBAction func btn_editar(_ sender: Any) {
        if (self.btn_editarOutlet.title == "Ok"){
            self.lbl_edicionActiva.isHidden = true
            self.btn_editarOutlet.title = "Editar"
            self.textLbl_correo.isEnabled = false
            self.textLbl_nombre.isEnabled = false
        
            userData.nombre = self.textLbl_nombre.text!
            userData.correo = self.textLbl_correo.text!
            
            let docDataUpdate: [String: Any] = [
                "nombre": self.textLbl_nombre.text!,
                "correo": self.textLbl_correo.text!
            ]
            
            db.collection("users").document(userData.uid).setData(docDataUpdate, merge: true)
            
            let alertController = UIAlertController(title: "Guardado", message: "Los datos se actualizaron correctamente", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
            })
            self.present(alertController, animated: true, completion: nil)
            
        }else {
            self.lbl_edicionActiva.isHidden = false
            self.btn_editarOutlet.title = "Ok"
            self.textLbl_correo.isEnabled = true
            self.textLbl_nombre.isEnabled = true
          
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_edicionActiva.isHidden = true
        self.textLbl_nombre.text = userData.nombre
        self.textLbl_correo.text = userData.correo
        if (userData.premium == true){
            self.textLbl_tipoDeCuenta.text = "Premium"
        }else {
            self.textLbl_tipoDeCuenta.text = "Gratuita"
        }
        if (userData.colaborador == true){
            self.textLbl_colaborador.text = "Si"
        }else {
            self.textLbl_colaborador.text = "No"
        }
        self.textLbl_uid.text = userData.uid
        self.textLbl_correo.isEnabled = false
        self.textLbl_nombre.isEnabled = false
        self.textLbl_tipoDeCuenta.isEnabled = false
        self.textLbl_colaborador.isEnabled = false
        self.textLbl_uid.isEnabled = false
        // Do any additional setup after loading the view.
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
