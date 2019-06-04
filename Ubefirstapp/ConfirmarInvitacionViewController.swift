//
//  ConfirmarInvitacionViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 6/1/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit

class ConfirmarInvitacionViewController: UIViewController {

    @IBOutlet weak var txt_nombre: UILabel!
    @IBOutlet weak var txt_correo: UILabel!
    @IBOutlet weak var txtArea_hijos: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_nombre.text = busquedaColaboradorData.nombre
        self.txt_correo.text = busquedaColaboradorData.correo
        self.txtArea_hijos.text = ""

        for i in (0...hijosSelected.count-1){
            self.txtArea_hijos.text = self.txtArea_hijos.text + userData.hijos[hijosSelected[i]].nombre + "\n"
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btn_enviarInvitacionPressed(_ sender: Any) {
        if (invitacionSegue==false){
            let docDataUpdate: [String:Any] = [
                "invitaciones_colaborador": true
            ]
            db.collection("users").document(busquedaColaboradorData.uid).setData(docDataUpdate, merge: true)
            let alertController = UIAlertController(title: "Invitación enviada correctamente", message: "Ahora " + busquedaColaboradorData.nombre + " deberá aceptar la invitación para que puedan empezar a colaborar", preferredStyle:UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { UIAlertAction in
                alertController.dismiss(animated: true, completion: nil)
                self.popBack(5)
            })
            self.present(alertController, animated: true, completion: nil)
            let id = db.collection("users").document().documentID
            
            var docIDHijos = [String?]()
            var hijosNombre = [String?]()
            for i in (0...hijosSelected.count-1){
                docIDHijos.append(userData.hijosref[hijosSelected[i]])
                hijosNombre.append(userData.hijos[hijosSelected[i]].nombre)
            }
            
            let id2 = db.collection("users").document().documentID

            let docData: [String:Any] = [
                "userUID": userData.uid,
                "nombre": userData.nombre,
                "correo": userData.correo,
                "hijos_compartidos_ref": docIDHijos,
                "hijos_compartidos_nombre": hijosNombre,
                "suscripcion": userData.premium,
                "status": "Invitacion pendiente por aceptar",
                "idInvitacion": id,
                "idInvitacionTitular": id2,
                "nhijos": userData.hijosref.count
            ]
            
            db.collection("users").document(busquedaColaboradorData.uid).collection("invitaciones").document(id).setData(docData)
            
            let docDataColaborador: [String:Any] = [
                "nombre": busquedaColaboradorData.nombre,
                "correo": busquedaColaboradorData.correo,
                "nhijos":busquedaColaboradorData.nHijos,
                "suscripcion":busquedaColaboradorData.suscripcion,
                "status": "Invitación enviada",
                "userUID": busquedaColaboradorData.uid,
                "hijos_compartidos": hijosSelected
                
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
            colaborador.usuarioUID=busquedaColaboradorData.uid
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
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
}
