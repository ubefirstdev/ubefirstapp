//
//  FormularioRecuerdoViewController.swift
//  Ubefirst
//
//  Created by MariaJose De la Fuente on 29/12/18.
//  Copyright © 2018 Roman Falcon. All rights reserved.
//

import UIKit


class FormularioRecuerdoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageview_previaImagen: UIImageView!
    @IBOutlet weak var textField_nombreRecuerdo: UITextField!
    @IBOutlet weak var textField_ubicacionRecuerdo: UITextField!
    @IBOutlet weak var textField_descripcionRecuerdo: UITextView!
    @IBOutlet weak var picker_persona: UIPickerView!
    @IBOutlet weak var picker_dimension: UIPickerView!
    @IBOutlet weak var picker_fecha: UIDatePicker!
    @IBOutlet weak var button_agregarRecuerdo: UIBarButtonItem!
    
    @IBAction func btnAgregar_pressed(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageview_previaImagen.image = imagenRecuerdoBuffer
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField_nombreRecuerdo.resignFirstResponder()
        self.textField_ubicacionRecuerdo.resignFirstResponder()
        self.textField_descripcionRecuerdo.resignFirstResponder()
    }
    
}


