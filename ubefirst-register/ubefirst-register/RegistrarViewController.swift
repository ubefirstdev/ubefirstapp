//
//  RegistrarViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 18/10/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit

class RegistrarViewController: UIViewController {
    
    @IBOutlet weak var textField_nombreRegistro: UITextField!
    @IBOutlet weak var textField_apellidoRegistro: UITextField!
    @IBOutlet weak var textField_correoRegistro: UITextField!
    @IBOutlet weak var textField_passwordRegistro: UITextField!
    @IBOutlet weak var btn_crearCuentaRegistro: UIButton!
    
    @IBAction func btn_crearCuentaRegistroPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.btn_crearCuentaRegistro.layer.cornerRadius = 10
        self.textField_passwordRegistro.isSecureTextEntry = true


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //metodo para que al presionar "intro" en el teclado, el teclado se oculte
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField_nombreRegistro.resignFirstResponder()
        self.textField_apellidoRegistro.resignFirstResponder()
        self.textField_correoRegistro.resignFirstResponder()
        self.textField_passwordRegistro.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
