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
                self.popBack(3)
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
            
            let id2 = db.collection("users").document().documentID
            let docDataColaborador: [String:Any] = [
                "nombre": busquedaColaboradorData.nombre,
                "correo": busquedaColaboradorData.correo,
                "nhijos":busquedaColaboradorData.nHijos,
                "suscripcion":busquedaColaboradorData.suscripcion,
                "status": "Invitación enviada",
                "docid": id2
                
            ]
            db.collection("users").document(userData.uid).collection("colaboradores").document(id2).setData(docDataColaborador)
            
            let docDataUpdate3: [String:Any] = [
                "colaboradoresactivos": true
                
            ]
            db.collection("users").document(userData.uid).setData(docDataUpdate3, merge: true)
            
            
            let colaborador = Colaborador()
            colaborador.nombre=busquedaColaboradorData.nombre
            colaborador.correo=busquedaColaboradorData.correo
            colaborador.nhijos=busquedaColaboradorData.nHijos
            colaborador.statusInvitacion="Invitacion enviada"
            colaborador.id=id2
            if (busquedaColaboradorData.suscripcion==true){
                colaborador.suscripcion="Premium"
            }else{
                colaborador.suscripcion = "Gratis"
            }
            
            userData.colaboradores.append(colaborador)
            
        }else{
            //codigo para aceptar la invitacion
            let alertController = UIAlertController(title: "Actualizando datos", message: "un momento porfavor", preferredStyle:UIAlertController.Style.alert)
            self.present(alertController, animated: true, completion: nil)

            print("invitacion aceptada")
             let docDataUpdate1: [String:Any] = [
             "colaborador":true
             ]
            
             db.collection("users").document(userData.uid).setData(docDataUpdate1, merge: true)
            
            let docDataUpdate2: [String:Any] = [
                "status":"Colaborando"
            ]
            db.collection("users").document(userData.uid).collection("invitaciones").document(busquedaColaboradorData.idInvitacion).setData(docDataUpdate2, merge: true)
            
            db.collection("users").document(busquedaColaboradorData.uid).collection("colaboradores").whereField("correo", isEqualTo: userData.correo).getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let docDataUpdate: [String:Any] = [
                                "status": "Invitación aceptada. En colaboración"
                            ]
                            db.collection("users").document(busquedaColaboradorData.uid).collection("colaboradores").document(document.documentID).setData(docDataUpdate, merge: true)
                        }
                        
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
                            alertController.dismiss(animated: false, completion: nil)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //funcion callback despues de 0.4 segundos
                                self.performSegue(withIdentifier: "PerfilDeUsuarioToLogin", sender: nil)
                            }
                        }
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

    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }

}
