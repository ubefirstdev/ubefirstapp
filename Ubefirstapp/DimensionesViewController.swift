//
//  DimensionesViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 26/12/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit

class DimensionesViewController: UIViewController {

    @IBOutlet weak var label_nombrePersona: UILabel!
    @IBOutlet weak var button_dimension1: UIButton!
    @IBOutlet weak var button_dimension2: UIButton!
    @IBOutlet weak var button_dimension3: UIButton!
    @IBOutlet weak var button_dimension4: UIButton!
    @IBOutlet weak var button_dimension5: UIButton!
    @IBOutlet weak var button_dimension6: UIButton!
    @IBOutlet weak var button_dimension7: UIButton!
    @IBOutlet weak var button_dimension8: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButtonsTitles()
        self.label_nombrePersona.text=userData.hijos[lastPersonIndexTap].alias
        loadDimensionesFromMemory()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearButtonsTitles(){
        self.button_dimension1.setTitle("", for: .normal)
        self.button_dimension2.setTitle("", for: .normal)
        self.button_dimension3.setTitle("", for: .normal)
        self.button_dimension4.setTitle("", for: .normal)
        self.button_dimension5.setTitle("", for: .normal)
        self.button_dimension6.setTitle("", for: .normal)
        self.button_dimension7.setTitle("", for: .normal)
        self.button_dimension8.setTitle("", for: .normal)
    }
    
    func loadDimensionesFromMemory(){
        for var i in 0...userData.hijos[lastPersonIndexTap].dimensiones.count-1{
            if (i==0){
                self.button_dimension1.setTitle(userData.hijos[lastPersonIndexTap].dimensiones[i].nombre, for: .normal)
            }
            if (i==1){
                self.button_dimension2.setTitle(userData.hijos[lastPersonIndexTap].dimensiones[i].nombre, for: .normal)

            }
            if (i==2){
                self.button_dimension3.setTitle(userData.hijos[lastPersonIndexTap].dimensiones[i].nombre, for: .normal)

            }
            if (i==3){
                self.button_dimension4.setTitle(userData.hijos[lastPersonIndexTap].dimensiones[i].nombre, for: .normal)

            }
            if (i==4){
                self.button_dimension5.setTitle(userData.hijos[lastPersonIndexTap].dimensiones[i].nombre, for: .normal)

            }
            if (i==5){
                self.button_dimension6.setTitle(userData.hijos[lastPersonIndexTap].dimensiones[i].nombre, for: .normal)

            }
            if (i==6){
                self.button_dimension7.setTitle(userData.hijos[lastPersonIndexTap].dimensiones[i].nombre, for: .normal)

            }
            if (i==7){
                self.button_dimension8.setTitle(userData.hijos[lastPersonIndexTap].dimensiones[i].nombre, for: .normal)

            }
            
            i=i+1
        }
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
