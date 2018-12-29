//
//  ViewController.swift
//  Ubefirst
//
//  Created by Gustavo Falcon Flanders on 12/20/18.
//  Copyright © 2018 Roman Falcon. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {
    @IBOutlet weak var button_crearCuentaRegistro: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // self.textField_passwordRegistro.isSecureTextEntry = true

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /*self.textField_nombreRegistro.resignFirstResponder()
        self.textField_apellidoRegistro.resignFirstResponder()
        self.textField_correoRegistro.resignFirstResponder()
        self.textField_passwordRegistro.resignFirstResponder()*/
        return true
    }

    
}

