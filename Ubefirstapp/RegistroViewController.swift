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
        if(validar(nombre: nombre,apellido: apellido,correo: correo,contraseña: contraseña)&&isValidEmail(email: correo)&&isValidPassword(password: contraseña)){
            
        // [START create_user]
        Auth.auth().createUser(withEmail: correo, password: contraseña) { (authResult, error) in
            // [START_EXCLUDE]
                guard let email = authResult?.user.email, error == nil else {
                    //Si esta mal elformato del correo
                    //Si la contraseña tiene menos de 6 caracteres
                    //Si el correo ya esta registrado
                    //Si validamos los dos primeros puntos antes podemos enviar un mensaje asegurando que es el punto 3
                    let alertController = UIAlertController(title: "Error en registro", message: "Este correo electronico ya esta registrado", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    print("mal")
                    return
            }
            //Cuenta creada
            let alertController = UIAlertController(title: "Felicidades", message: "Cuenta creada de manera correcta.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Iniciar Sesión", style: UIAlertAction.Style.default) { UIAlertAction in
                self.toLogIn()
            })
            self.present(alertController, animated: true, completion: nil)
            // [END_EXCLUDE]
            guard let user = authResult?.user else { return }
            userData.uid = user.uid
            
            let newUserFirestore = LoadDataToFirestore()
            newUserFirestore.agregarNuevoUsuario(uid: userData.uid, nombre: nombre, correo: correo)
            }
        // [END create_user

        }
    }
 
    func toLogIn() {
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "registerToLogIn", sender: self)
        }
    }
    
    func validar(nombre: String,apellido: String,correo: String, contraseña: String) -> Bool
    {
        if(nombre==""||apellido==""||correo==""||contraseña=="")
        {
            //Se indica que algun campo esta incompleto
            let alertController = UIAlertController(title: "Error en registro", message: "Favor de llenar todos los campos", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if(pred.evaluate(with: email))
        {
            return true
        }
        else
        {
            let alertController = UIAlertController(title: "Error en registro", message: "Formato de correo electronico incorrecto", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return false
        }
    }
    
    func isValidPassword(password:String?) -> Bool {
        guard password != nil else { return false }
        if password!.count<6{
            let alertController = UIAlertController(title: "Error en registro", message: "Formato en contraseña incorrecto. (Debe contener al menos 6 caracteres)", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
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

