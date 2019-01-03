//
//  PersonasViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 29/12/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit

var lastPersonIndexTap: Int!

class PersonasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellReuseIdentifier = "PersonasCell"
    
    @IBOutlet weak var personasTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personasTableView.delegate = self
        self.personasTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //numero de celdas en la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.hijos.count
    }
    
    //creacion de cada celda de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PersonasTableViewCell = self.personasTableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as! PersonasTableViewCell
        cell.lbl_nombreHijo.text=userData.hijos[indexPath.row].alias
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastPersonIndexTap=indexPath.row
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "PersonasToDimensiones", sender: self)
        }
        tableView.reloadData()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
