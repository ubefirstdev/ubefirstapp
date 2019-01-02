//
//  FormularioRecuerdoViewController.swift
//  Ubefirst
//
//  Created by MariaJose De la Fuente on 29/12/18.
//  Copyright © 2018 Roman Falcon. All rights reserved.
//

import UIKit


class FormularioRecuerdoViewController: UIViewController {

    @IBOutlet weak var imageview_previaImagen: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageview_previaImagen.image = imagenRecuerdoBuffer
        // Do any additional setup after loading the view.
    }
    

}
