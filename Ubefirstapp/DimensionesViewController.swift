//
//  DimensionesViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 26/12/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit

var lastIndexDimensionTap: Int!

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
    
    @IBAction func btnPressed_dimension1(_ sender: Any) {
        if (userData.premium==true){
            lastIndexDimensionTap = 0
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "DimensionToRecuerdos", sender: self)
            }
        } else {
            let alertController = UIAlertController(title: "Funcionalidad limitada", message: "Obtenga una cuenta ubefirst Premium para acceder a esta dimensión", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
            })
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    @IBAction func btnPressed_dimension2(_ sender: Any) {
        if (userData.premium==true){
            lastIndexDimensionTap = 1
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "DimensionToRecuerdos", sender: self)
            }
        }else {
            let alertController = UIAlertController(title: "Funcionalidad limitada", message: "Obtenga una cuenta ubefirst Premium para acceder a esta dimensión", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
            })
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func btnPreseed_dimension3(_ sender: Any) {
        if (userData.premium==true){
            lastIndexDimensionTap = 2
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "DimensionToRecuerdos", sender: self)
            }
        } else {
            let alertController = UIAlertController(title: "Funcionalidad limitada", message: "Obtenga una cuenta ubefirst Premium para acceder a esta dimensión", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
            })
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func btnPressed_dimension4(_ sender: Any) {
        if (userData.premium==true){
            lastIndexDimensionTap = 3
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "DimensionToRecuerdos", sender: self)
            }
        } else {
            let alertController = UIAlertController(title: "Funcionalidad limitada", message: "Obtenga una cuenta ubefirst Premium para acceder a esta dimensión", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
            })
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func btnPressed_dimension5(_ sender: Any) {
        lastIndexDimensionTap = 4
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "DimensionToRecuerdos", sender: self)
        }
    }
    
    @IBAction func btnPressed_dimension6(_ sender: Any) {
        lastIndexDimensionTap = 5
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "DimensionToRecuerdos", sender: self)
        }
    }
    
    @IBAction func btnPressed_dimension7(_ sender: Any) {
        lastIndexDimensionTap = 6
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "DimensionToRecuerdos", sender: self)
        }
    }
    
    @IBAction func btnPressed_dimension8(_ sender: Any) {
        if (userData.premium==true){
            lastIndexDimensionTap = 7
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "DimensionToRecuerdos", sender: self)
            }
        } else {
            let alertController = UIAlertController(title: "Funcionalidad limitada", message: "Obtenga una cuenta ubefirst Premium para acceder a esta dimensión", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
            })
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func buttonAgregarRecuerdo_pressed(_ sender: Any) {
        segueSender = "DimensionesToAgregarRecuerdo"
        CameraHandler.shared.showActionSheet(vc: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButtonsTitles()
        self.label_nombrePersona.text=userData.hijos[lastPersonIndexTap].alias
        loadDimensionesFromMemory()
        
        if (userData.premium==false){
            button_dimension1.isEnabled = false
            button_dimension2.isEnabled = false
            button_dimension3.isEnabled = false
            button_dimension4.isEnabled = false
            button_dimension8.isEnabled = false
        }

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
