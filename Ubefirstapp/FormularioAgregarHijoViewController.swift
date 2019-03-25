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
        let update = LoadDataToFirestore()
        update.agregarHijoNuevoAndReturnHijoref(alias: self.textfield_alias.text!, nombre: self.textfield_nombre.text!)
        self.navigationController?.popViewController(animated: true)
        flagNuevoHijo=1

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
