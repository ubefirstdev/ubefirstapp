//
//  AceptarInvitacionViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 6/1/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit

class AceptarInvitacionViewController: UIViewController {

    @IBOutlet weak var txt_nombre: UILabel!
    @IBOutlet weak var txt_correo: UILabel!
    @IBOutlet weak var txtArea_hijos: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_nombre.text = busquedaColaboradorData.nombre
        self.txt_correo.text = busquedaColaboradorData.correo
        self.txtArea_hijos.text = ""

        for i in (0...busquedaColaboradorData.hijosCompartidosNombres.count-1){
            self.txtArea_hijos.text = self.txtArea_hijos.text + busquedaColaboradorData.hijosCompartidosNombres[i]! + "\n"
        }
        
    }
    
    @IBAction func btn_aceptarInvitacionPressed(_ sender: Any) {
        print("invitacion aceptada")
    }
    
    
}
