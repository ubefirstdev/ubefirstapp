//
//  GestionColaboradoresViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 06/03/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit
var lastColaboradorConfigPersonTap: Int!
class GestionColaboradoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ColaboradoresTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    func setupTableView(){
        self.ColaboradoresTableView.delegate = self
        self.ColaboradoresTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.colaboradores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell3 = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell3")
        cell3.textLabel?.text  = userData.colaboradores[indexPath.row].nombre
        
        return cell3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastColaboradorConfigPersonTap = indexPath.row
        self.ColaboradoresTableView.deselectRow(at: indexPath, animated: true)
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
