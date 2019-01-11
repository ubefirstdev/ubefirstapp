//
//  RecuerdosDetallesViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 10/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit

class RecuerdosDetallesViewController: UIViewController {

    @IBOutlet weak var lbl_titulo: UILabel!
    @IBOutlet weak var lbl_hijo: UILabel!
    @IBOutlet weak var lbl_dimension: UILabel!
    @IBOutlet weak var lbl_fecha: UILabel!
    @IBOutlet weak var lbl_ubicacion: UILabel!
    @IBOutlet weak var txtView_descripcion: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].titulo
        self.lbl_titulo.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].titulo
        self.lbl_hijo.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].hijo

        self.lbl_dimension.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].dimension
        self.lbl_fecha.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].fecha
        self.lbl_ubicacion.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].ubicacion
        self.txtView_descripcion.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].descripcion

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
