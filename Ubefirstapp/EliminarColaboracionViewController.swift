//
//  EliminarColaboracionViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 6/3/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit

class EliminarColaboracionViewController: UIViewController {

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

    @IBAction func btn_eliminarVinculacionPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "¿Eliminar vinculación con " + busquedaColaboradorData.nombre + " ?", message: "Esta acción eliminará a las personas compartidas por este usuario de tu cuenta", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default) { UIAlertAction in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(UIAlertAction(title: "Eliminar", style: UIAlertAction.Style.destructive) { UIAlertAction in
            
             let alertController2 = UIAlertController(title: "Eliminando vinculación", message: "Un momento porfavor", preferredStyle: UIAlertController.Style.alert)
            self.present(alertController2, animated: true, completion: nil)

            var hijosTotales = userData.hijosref
            
            for i in (0...userData.hijosref.count-1){
                for ii in (0...busquedaColaboradorData.hijosCompartidosRef.count-1){
                    if (hijosTotales![i]==busquedaColaboradorData.hijosCompartidosRef[ii]){
                        hijosTotales![i]="nil"
                    }
                }
            }
            
            var array = [String]()
            for i in (0...hijosTotales!.count-1){
                if (hijosTotales![i] != "nil"){
                    array.append(hijosTotales![i])
                }
            }
            
            var docUpdate: [String : Any] = [:]
            if (invitacionBusqueda.count==1){
                docUpdate = [
                    "hijosref": array,
                    "colaborador": false,
                    "invitaciones_colaborador": false
                    ] as [String : Any]
            
            }else{
                docUpdate = [
                    "hijosref": hijosTotales!,
                    ] as [String : Any]
            }
            
            let docUpdate2 = [
                "status": "Colaboración terminada"
                ] as [String : Any]
            
            db.collection("users").document(userData.uid).setData(docUpdate, merge: true)
            
            db.collection("users").document(busquedaColaboradorData.uid).collection("colaboradores").document(busquedaColaboradorData.idInvitacionTitular).setData(docUpdate2, merge: true)
            
            db.collection("users").document(userData.uid).collection("invitaciones").document(busquedaColaboradorData.idInvitacion).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    userData  = Padre.init()
                    alertController2.dismiss(animated: true, completion: {
                        OperationQueue.main.addOperation {
                            [weak self] in
                            self?.performSegue(withIdentifier: "DeleteInvitacionToLoadingPage", sender: self)
                        }
                    })
                }
            }
            
        })
        self.present(alertController, animated: true, completion: nil)
        
    }
}
