//
//  ViewController.swift
//  Ubefirst
//
//  Created by Gustavo Falcon Flanders on 12/20/18.
//  Copyright © 2018 Roman Falcon. All rights reserved.
//

import UIKit
import Firebase

class RegistroViewController: UIViewController {

    @IBOutlet weak var inputNombre: UITextField!
    
    @IBOutlet weak var inputApellido: UITextField!
    
    @IBOutlet weak var inputCorreo: UITextField!

    @IBOutlet var inputContraseña: UITextField!

    
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
        
        let nombre = inputNombre.text!
        let apellido = inputApellido.text!
        let correo = inputCorreo.text!
        let contraseña = inputContraseña.text!
        
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        var ref: DocumentReference? = nil
        
        if(validar(nombre: nombre,apellido: apellido,correo: correo,contraseña: contraseña)){
        //Se revisa si el correo no esta asociado a una cuenta
        //Falta validar si el correo ya esta registrado
        //!!!
            ref = db.collection("Usuarios").addDocument(data: [
                "correo": correo,
                "nombre": nombre+" "+apellido,
                "contraseña": contraseña,
                "CreadoEn": NSDate(),
                "Hijos": ["caca","qk","boy","girl"]
                ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    //Almacenar el documentID en estructura padre
                    let alertController = UIAlertController(title: "Felicidades", message: "Cuenta creada de manera correcta.", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "Iniciar Sesión", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.toLogIn()
                    })
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    else{
        //Se indica que algun campo esta incompleto
            let alertController = UIAlertController(title: "Error en registro", message: "Favor de llenar todos los campos", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func toLogIn() {
   //Enviar a pantalla de log in
        /* OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "login", sender: self)
        }
 */
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

