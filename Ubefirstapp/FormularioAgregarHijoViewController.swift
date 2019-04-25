//
//  FormularioAgregarHijoViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 03/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit

var flagNuevoHijo = 0
class FormularioAgregarHijoViewController: UIViewController {

    
    @IBOutlet weak var textfield_nombre: UITextField!
    @IBOutlet weak var textfield_alias: UITextField!
    @IBOutlet weak var textfield_relacion: UITextField!
    
    @IBAction func btnGuardar_pressed(_ sender: Any) {
        
        if(validar(str: self.textfield_nombre.text!)&&validar(str: self.textfield_alias.text!)&&validar(str: self.textfield_relacion.text!)){
            let update = LoadDataToFirestore()
            update.agregarHijoNuevoAndReturnHijoref(alias: self.textfield_alias.text!, nombre: self.textfield_nombre.text!,parent: self.textfield_relacion.text!)
            self.navigationController?.popViewController(animated: true)
            flagNuevoHijo=1
        }
        else{
            //Se indica que el campo esta incompleto
            let alertController = UIAlertController(title: "Error en registro", message: "Favor de llenar todos los campos", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //metodo para que al presionar "intro" en el teclado, el teclado se oculte
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_nombre.resignFirstResponder()
        self.textfield_alias.resignFirstResponder()

        self.textfield_relacion.resignFirstResponder()
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func validar(str: String) -> Bool{return !(str=="")}
}
