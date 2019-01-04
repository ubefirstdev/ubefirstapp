//
//  FormularioAgregarHijoViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 03/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit

class FormularioAgregarHijoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let array = ["hola", "como", "estas"]
        print(array)
        let clss = LoadDataToFirestore()
        //let c = clss.makeStringFromArray(StringsArray: userData.hijosref)
        clss.guarddocTest()
        //print(c)
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
