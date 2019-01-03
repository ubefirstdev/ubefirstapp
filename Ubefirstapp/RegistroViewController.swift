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
    
    @IBAction func CrearCuenta(_ sender: UIButton) {
        
        let nombre = inputNombre.text!
        let apellido = inputApellido.text!
        let correo = inputCorreo.text!
        let contraseña = inputContraseña.text!
        
        //Revisa si no estan vacios los inputs
        if(validar(nombre: nombre,apellido: apellido,correo: correo,contraseña: contraseña)){
            
        //revisar si el formato del correo esta bien puesto y contraseña mayor de 6 digitos

            
        // [START create_user]
        Auth.auth().createUser(withEmail: correo, password: contraseña) { (authResult, error) in
            // [START_EXCLUDE]
                guard let email = authResult?.user.email, error == nil else {
                    //Si esta mal elformato del correo
                    //Si la contraseña tiene menos de 6 caracteres
                    //Si el correo ya esta registrado
                    //Si validamos los dos primeros puntos antes podemos enviar un mensaje asegurando que es el punto 3
                    print("mal")
                    return
            }
            //Cuenta creada
            print("bien")
            // [END_EXCLUDE]
            guard let user = authResult?.user else { return }
        }
        // [END create_user]
        }
        else{
            //Se indica que algun campo esta incompleto
            let alertController = UIAlertController(title: "Error en registro", message: "Favor de llenar todos los campos", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        /* Creacion de documento para usuarios
 
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        var ref: DocumentReference? = nil
        
        if(validar(nombre: nombre,apellido: apellido,correo: correo,contraseña: contraseña)){
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
 */
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
    
}

