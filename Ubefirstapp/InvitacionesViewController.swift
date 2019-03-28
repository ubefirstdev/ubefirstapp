//
//  InvitacionesViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 09/03/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

import UIKit
var lastInvitacionConfigPersonTap: Int!

class InvitacionesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var InvitacionesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.InvitacionesTableView.delegate = self
        self.InvitacionesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invitacionBusqueda.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell4 = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell4")
        cell4.textLabel?.text  = invitacionBusqueda[indexPath.row].nombre
        cell4.detailTextLabel?.text = invitacionBusqueda[indexPath.row].status
        
        return cell4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastInvitacionConfigPersonTap = indexPath.row
        busquedaColaboradorData = invitacionBusqueda[indexPath.row]
        self.InvitacionesTableView.deselectRow(at: indexPath, animated: true)
        
        if (busquedaColaboradorData.status=="Colaborando"){
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "InvitacionesToDeletePerfil", sender: self)
            }
        }else{
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "InvitacionesToPerfilInvitacion", sender: self)
            }
        }
        
    }
    

}
