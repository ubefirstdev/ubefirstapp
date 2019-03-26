//
//  PerfilColaboradorViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 08/03/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit
var invitacionSegue:Bool!

class PerfilColaboradorViewController: UIViewController {
    @IBOutlet weak var lbl_nombre: UILabel!
    @IBOutlet weak var lbl_correo: UILabel!
    @IBOutlet weak var lbl_suscripcion: UILabel!
    @IBOutlet weak var lbl_nHijos: UILabel!
    @IBOutlet weak var btnConfirmacion: UIButton!
    
    @IBAction func btn_confirmarPressed(_ sender: Any) {
        if (invitacionSegue==false){
            let docDataUpdate: [String:Any] = [
                "invitaciones_colaborador": true
            ]
            db.collection("users").document(busquedaColaboradorData.uid).setData(docDataUpdate, merge: true)
            let alertController = UIAlertController(title: "Invitación enviada correctamente", message: "Ahora " + busquedaColaboradorData.nombre + " deberá aceptar la invitación para que puedan empezar a colaborar", preferredStyle:UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { UIAlertAction in
                alertController.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alertController, animated: true, completion: nil)
            let id = db.collection("users").document().documentID
            
            let docData: [String:Any] = [
                "uid": userData.uid,
                "nombre": userData.nombre,
                "correo": userData.correo,
                "nhijos":userData.hijos.count,
                "suscripcion": userData.premium,
                "status": "Invitacion pendiente por aceptar",
                "idInvitacion": id
            ]
            
            db.collection("users").document(busquedaColaboradorData.uid).collection("invitaciones").document(id).setData(docData)
            
        }else{
            //codigo para aceptar la invitacion
            print("invitacion aceptada")
             let docDataUpdate1: [String:Any] = [
             "colaborador":true
             ]
            
             db.collection("users").document(userData.uid).setData(docDataUpdate1, merge: true)
            
            let docDataUpdate2: [String:Any] = [
                "status":"Colaborando"
            ]
        db.collection("users").document(userData.uid).collection("invitaciones").document(busquedaColaboradorData.idInvitacion).setData(docDataUpdate2, merge: true)
            
           db.collection("users").document(busquedaColaboradorData.uid).getDocument{(document, error) in
                if error != nil {
                    print(error!)
                }else{
                    let hijosref = document?.data()!["hijosref"] as? [String]
                    for element in hijosref!{
                        userData.hijosref.append(element)
                    }
                    let instance = LoadDataToFirestore()
                    instance.agregarReferenciaNuevoHijo()
                    OperationQueue.main.addOperation {
                        [weak self] in
                        self?.performSegue(withIdentifier: "PerfilDeUsuarioToLogin", sender: self)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (invitacionSegue==true){
            btnConfirmacion.setTitle("Aceptar invitación",for: .normal)
        }
        self.lbl_nombre.text=self.lbl_nombre.text! + busquedaColaboradorData.nombre
        self.lbl_correo.text=self.lbl_correo.text! + busquedaColaboradorData.correo
        self.lbl_nHijos.text=self.lbl_nHijos.text! + String(busquedaColaboradorData.nHijos)
        if (busquedaColaboradorData.suscripcion==true){
            self.lbl_suscripcion.text=self.lbl_suscripcion.text! + "Premium"
        }else{
             self.lbl_suscripcion.text=self.lbl_suscripcion.text! + "Gratis"
        }
       
       /* if(invitacionBusqueda[lastInvitacionConfigPersonTap].status == "Colaborando" && invitacionSegue==true){
            //cambio etiqueta al boton y cambio el color del boton
            self.btnConfirmacion.layer.cornerRadius = 5
            self.btnConfirmacion.layer.borderWidth = 1
            self.btnConfirmacion.layer.borderColor = UIColor.red.cgColor
            self.btnConfirmacion.setTitle("Eliminar colaboración",for: .normal)
            self.btnConfirmacion.setTitleColor(UIColor.red, for: UIControl.State.normal)


        }*/
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
