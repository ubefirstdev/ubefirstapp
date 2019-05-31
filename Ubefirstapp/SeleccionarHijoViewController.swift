//
//  SeleccionarHijoViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 5/31/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit

var hijosSelected = [Int]()

class SeleccionarHijoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var btn_elegirHijo: UIButton!
    @IBOutlet weak var tableViewHijos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.btn_elegirHijo.layer.cornerRadius = 10
        self.btn_elegirHijo.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func setupTableView (){
        self.tableViewHijos.delegate = self
        self.tableViewHijos.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.hijos.count
    }
    
    
    //creacion de cada celda de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PersonasTableViewCell = self.tableViewHijos.dequeueReusableCell(withIdentifier: "PersonasCell2") as! PersonasTableViewCell
        cell.lbl_nombreHijo.text=userData.hijos[indexPath.row].alias
        cell.lbl_parentesco.text=userData.hijos[indexPath.row].parentesco
        
        /*let backgroundView = UIView()
        backgroundView.backgroundColor = el color
        cell.selectedBackgroundView = backgroundView*/
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
        
        hijosSelected.append(indexPath.row)
        self.btn_elegirHijo.isHidden = false
        print(hijosSelected)
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("tap")
        
        for index in (0...hijosSelected.count-1) {
            if (hijosSelected[index] == indexPath.row){
                hijosSelected.remove(at: index)
                break
            }
        }

        
        if (hijosSelected.isEmpty){
            self.btn_elegirHijo.isHidden = true
        }
        print(hijosSelected)
        
    }
    
    
    @IBAction func btn_elegirPressed(_ sender: Any) {
    }
    

}
