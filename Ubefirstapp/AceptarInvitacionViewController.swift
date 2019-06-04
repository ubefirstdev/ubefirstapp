//
//  AceptarInvitacionViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 6/1/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit

class AceptarInvitacionViewController: UIViewController {

    @IBOutlet weak var txt_nombre: UILabel!
    @IBOutlet weak var txt_correo: UILabel!
    @IBOutlet weak var txtArea_hijos: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_nombre.text = busquedaColaboradorData.nombre
        self.txt_correo.text = busquedaColaboradorData.correo
        self.txtArea_hijos.text = ""

        for i in (0...busquedaColaboradorData.hijosCompartidosNombres.count-1){
            self.txtArea_hijos.text = self.txtArea_hijos.text + busquedaColaboradorData.hijosCompartidosNombres[i]! + "\n"
        }
        
    }
    
    @IBAction func btn_aceptarInvitacionPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Vinculacion de cuentas", message: "La cuentas han sido vinculadas exitosamente, ahora tendras disponibles las personas que se te compartieron en la sección 'Personas' de tu aplicación", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { UIAlertAction in
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "AceptarInvitacionToLoading", sender: self)
            }
        })
        
        let array = busquedaColaboradorData.hijosCompartidosRef
        let docUpdate=[
            "colaborador": true,
            "hijosref": array
            ] as [String : Any]
        
        db.collection("users").document(userData.uid).setData(docUpdate, merge: true)
        
        let invitacionUpdate = [
            "status": "Colaborando"
        ] as [String:Any]
        
        db.collection("users").document(userData.uid).collection("invitaciones").document(busquedaColaboradorData.idInvitacion).setData(invitacionUpdate, merge: true)
        
        let colaboradoresUpdate = [
            "status": "Colaborando"
            ] as [String:Any]
        
    db.collection("users").document(busquedaColaboradorData.uid).collection("colaboradores").document(busquedaColaboradorData.idInvitacionTitular).setData(colaboradoresUpdate, merge: true)
        
        userData = Padre.init()
        
        self.present(alert, animated: true)

    }
    
    
}
