//
//  ViewController.swift
//  ubefirst-register
//
//  Created by MariaJose De la Fuente on 11/10/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var textField_usernameLogin: UITextField!
    @IBOutlet weak var textField_passwordLogin: UITextField!
    @IBOutlet weak var btn_forgotPassword: UIButton!
    @IBOutlet weak var btn_loginButton: UIButton!
    @IBOutlet weak var btn_googleLogin: GIDSignInButton!
    @IBOutlet weak var btn_facebookButton: UIButton!
    @IBOutlet weak var btn_registerButton: UIButton!
    
    @IBAction func btn_LoginUser(_ sender: Any) {
        //Validar el formato del correo y la contraseña y tambien que no esten vacios
        if (isValidEmail(email: textField_usernameLogin.text)&&isValidPassword(password: textField_passwordLogin.text))
        {
            Auth.auth().signIn(withEmail: textField_usernameLogin.text!, password: textField_passwordLogin.text!)
            { (user, error) in
                //Nos devuelve al usuario en formato
                let usuario = user?.user.uid
                
                if !(usuario==nil){
                    //Si entramos aqui quiere decir que ya se creo el nuevo usuario en AUTH
                    //Aqui debemos de setear en base de datos al usuario para que funcione correctamente cuando lo mandemos a la loading page
                    UserDefaults.standard.set(usuario, forKey: "accessTokenUID")
                    OperationQueue.main.addOperation {
                        [weak self] in
                        self?.performSegue(withIdentifier: "LoginToLoadingPage", sender: self)
                    }
                }
                else {
                    /*let alertController = UIAlertController(title: "Error en Inicio de Sesión", message: (error as! String), preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    print("error de inicio de sesion")*/
                    let alertController = UIAlertController(title: "Error de inicio de sesión", message: "No se pudo inciar sesion correctamente", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                    })
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                }
            }
            
        }
        else
        {
            //Se indica que algun campo esta incompleto
            let alertController = UIAlertController(title: "Error en Inicio de Sesión", message: "Es necesario ingresar los datos de forma correcta", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            print("datos incorrectos")
        }
    }
    
    @IBAction func btn_LoginGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    @IBAction func btn_LoginFacebook(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email","user_friends"], from: self)
        { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    //inicio de sesion cancelado
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    //inicio de sesion correcto
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    
                    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                        if let error = error {
                            //inicio de sesion con error al conectar con firebase
                            print("error de inicio de sesion al intentar conectar con el servidor de firebase")
                            return
                        }
                        userData.uid=Auth.auth().currentUser?.uid
                        userData.correo=Auth.auth().currentUser?.email
                        userData.nombre=Auth.auth().currentUser?.displayName


                        // User is signed in
                        //inicio de sesion correcto con firebase
                        OperationQueue.main.addOperation {
                         [weak self] in
                         self?.performSegue(withIdentifier: "LoginToLoadingPage", sender: self)
                         }
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //modifica la apariencia del boton a un boton con bordes redondeados
        self.btn_loginButton.layer.cornerRadius = 10
        //modifica el textfield para que se oculte la contraseña
        self.textField_passwordLogin.isSecureTextEntry = true
        GIDSignIn.sharedInstance().uiDelegate=self
        
        if (FBSDKAccessToken.current()==nil){
            //self.test_label.text="usuario desconectado"
        }else{
            //self.test_label.text="sesion activa"
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil{
           // self.lbl_logStatus.text = error.localizedDescription
        }else if result.isCancelled{
            //self.lbl_logStatus.text="inicio de sesion cancelado"
        } else {
            //self.lbl_logStatus.text="inicio de sesion correcto"
            
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                  //  self.lbl_logStatus.text="error con firebase"
                    return
                }
                // User is signed in
                
                userData.uid=Auth.auth().currentUser?.uid
                userData.correo=Auth.auth().currentUser?.email
                userData.nombre=Auth.auth().currentUser?.displayName
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //self.lbl_logStatus.text="usuario desconectado"
    }
    
    //sign in google+
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("failed to log in", error)
            return
        }else{
            print("login sucessfull", user)
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken:authentication.idToken,accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                print("error during firebase authentication", error)
                return
            }
            // User is signed in
            // ...
            print("user successfully login into firebase")
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "LoginToLoadingPage", sender: self)
            }
        }
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //metodo para que al presionar "intro" en el teclado, el teclado se oculte
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField_usernameLogin.resignFirstResponder()
        self.textField_passwordLogin.resignFirstResponder()
        return true
    }
    
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(password:String?) -> Bool {
        guard password != nil else { return false }
        if password!.count<6{
            return false
        }
        return true
    }
}

