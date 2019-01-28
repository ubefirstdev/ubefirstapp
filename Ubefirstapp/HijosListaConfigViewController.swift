//
//  HijosConfigViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 23/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit
var lastHijoConfigPersonTap: Int!

class HijosListaConfigViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewhijos: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.tableViewhijos.delegate = self
        self.tableViewhijos.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.hijos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell1")
        cell1.textLabel?.text  = userData.hijos[indexPath.row].nombre
        
        return cell1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastHijoConfigPersonTap = indexPath.row
        self.tableViewhijos.deselectRow(at: indexPath, animated: true)
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "HijosConfigTableToHijosData", sender: self)
        }
        
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
