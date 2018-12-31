//
//  ViewController.swift
//  Ubefirst
//
//  Created by Gustavo Falcon Flanders on 12/20/18.
//  Copyright © 2018 Roman Falcon. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {

    @IBOutlet weak var inputNombre: UITextField!
    
    @IBOutlet weak var inputApellido: UITextField!
    
    @IBOutlet var inputContraseña: UITextField!
    
    @IBOutlet weak var inputCorreo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //metodo para que al presionar "intro" en el teclado, el teclado se oculte
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.inputCorreo.resignFirstResponder()
        self.inputApellido.resignFirstResponder()
        self.inputNombre.resignFirstResponder()
        self.inputContraseña.resignFirstResponder()
        return true
    }
    
    @IBAction func CrearCuenta(_ sender: UIButton) {
        if(validar(nombre: inputNombre.text!,apellido: inputApellido.text!,correo: inputCorreo.text!,contraseña: inputContraseña.text!)){
        //Se revisa si el correo no esta asociado a una cuenta
        }
    else{
        //Se indica que algun campo esta incompleto
        }
    }
    
    func validar(nombre: String,apellido: String,correo: String, contraseña: String) -> Bool
    {
        if(nombre==""||apellido==""||correo==""||contraseña=="")
        {
            return false
        }
        return true
    }
    
}

