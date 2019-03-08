//
//  AgregarColaboradorViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 07/03/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit

class AgregarColaboradorViewController: UIViewController {
    @IBOutlet weak var txtField_correo: UITextField!
    
    @IBAction func btn_buscarUsuarioPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Buscando usuario", message: "Un momento porfavor", preferredStyle: UIAlertController.Style.alert)
        let alertController1 = UIAlertController(title: "El correo especificado no pertenece a ninguna cuenta registrada de ubefirst", message: "Compruebe que el correo proporcionado sea el correcto y que el usuario ya tenga una cuenta", preferredStyle:UIAlertController.Style.alert)
        alertController1.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { UIAlertAction in
            alertController1.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)

        db.collection("users").whereField("correo", isEqualTo: self.txtField_correo.text!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if ((querySnapshot?.isEmpty)!){
                alertController.dismiss(animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { //funcion callback despues de 0.4 segundos
                    self.present(alertController1, animated: true, completion: nil)
                }
                    
            }else {
                print("usuario existe")
                alertController.dismiss(animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { //funcion callback despues de 0.4 segundos
                    OperationQueue.main.addOperation {
                        [weak self] in
                        self?.performSegue(withIdentifier: "AgregarColaboradorToColaboradorInfo", sender: self)
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func btn_invitarPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Generando invitación", message: "Un momento porfavor", preferredStyle: UIAlertController.Style.alert)
        self.present(alertController, animated: true, completion: nil)
        
        let invitacion: [String:Any] = [
            "cuenta_base":userData.correo,
            "cuenta_invitada": self.txtField_correo.text!
        ]
        
        db.collection("invitaciones").document().setData(invitacion) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
}
