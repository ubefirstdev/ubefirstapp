//
//  FormularioAgregarHijoViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 03/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit

class FormularioAgregarHijoViewController: UIViewController {

    
    @IBOutlet weak var textfield_nombre: UITextField!
    @IBOutlet weak var textfield_alias: UITextField!
    
    @IBAction func btnGuardar_pressed(_ sender: Any) {
        let update = LoadDataToFirestore()
        update.agregarHijoNuevo(alias: self.textfield_alias.text!, nombre: self.textfield_nombre.text!)
        self.navigationController?.popViewController(animated: true)

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
