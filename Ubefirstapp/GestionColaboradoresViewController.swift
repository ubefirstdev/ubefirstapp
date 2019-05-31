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
    
    override func viewDidAppear(_ animated: Bool) {
        self.ColaboradoresTableView.reloadData()
    }

    func setupTableView(){
        self.ColaboradoresTableView.delegate = self
        self.ColaboradoresTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.colaboradores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell3 = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell3")
        cell3.textLabel?.text  = userData.colaboradores[indexPath.row].nombre
        cell3.detailTextLabel?.text = userData.colaboradores[indexPath.row].statusInvitacion
        
        return cell3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastColaboradorConfigPersonTap = indexPath.row
        self.ColaboradoresTableView.deselectRow(at: indexPath, animated: true)
        
        if (userData.colaboradores[indexPath.row].statusInvitacion=="Invitación aceptada. En colaboración"){
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "ColaboradoresToDeletePerfil", sender: self)
            }
        }/*else{
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "HijosConfigTableToHijosData", sender: self)
            }
        }*/
    }
}
