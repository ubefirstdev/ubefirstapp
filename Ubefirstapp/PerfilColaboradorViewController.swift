//
//  PerfilColaboradorViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 08/03/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit
var invitacionSegue:Bool!

class PerfilColaboradorViewController: UIViewController {
    @IBOutlet weak var lbl_nombre: UILabel!
    @IBOutlet weak var lbl_correo: UILabel!
    @IBOutlet weak var lbl_suscripcion: UILabel!
    @IBOutlet weak var lbl_nHijos: UILabel!
    @IBOutlet weak var btnConfirmacion: UIButton!
    
    @IBAction func btn_confirmarPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (invitacionSegue==true){
            btnConfirmacion.setTitle("Aceptar invitación",for: .normal)
        }
        self.lbl_nombre.text=self.lbl_nombre.text! + busquedaColaboradorData.nombre
        self.lbl_correo.text=self.lbl_correo.text! + busquedaColaboradorData.correo
        self.lbl_nHijos.text=self.lbl_nHijos.text! + String(busquedaColaboradorData.nHijos)
        if (busquedaColaboradorData.suscripcion==true){
            self.lbl_suscripcion.text=self.lbl_suscripcion.text! + "Premium"
        }else{
             self.lbl_suscripcion.text=self.lbl_suscripcion.text! + "Gratis"
        }
       
       /* if(invitacionBusqueda[lastInvitacionConfigPersonTap].status == "Colaborando" && invitacionSegue==true){
            //cambio etiqueta al boton y cambio el color del boton
            self.btnConfirmacion.layer.cornerRadius = 5
            self.btnConfirmacion.layer.borderWidth = 1
            self.btnConfirmacion.layer.borderColor = UIColor.red.cgColor
            self.btnConfirmacion.setTitle("Eliminar colaboración",for: .normal)
            self.btnConfirmacion.setTitleColor(UIColor.red, for: UIControl.State.normal)


        }*/
        // Do any additional setup after loading the view.
    }

}
