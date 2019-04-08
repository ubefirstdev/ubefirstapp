//
//  RecuerdosViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 01/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit

var lastRecuerdoIndexTap: Int!

class RecuerdosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewRecuerdos: UITableView!
    @IBOutlet weak var imgDimension: UIImageView!
    
    @IBOutlet weak var labelPersona: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.title = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].nombre
        self.labelPersona.text=userData.hijos[lastPersonIndexTap].alias
        imagenDimension()
        // Do any additional setup after loading the view.
    }
    
    func imagenDimension()
    {
        switch      userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].nombre
        {
        case "Académica":
            imgDimension.image = UIImage(named:"BotonAcademico.png")
            break
        case "Cultural":
            imgDimension.image = UIImage(named:"BotonCultural.png")
            break
        case "Espiritual":
            imgDimension.image = UIImage(named:"BotonEspiritual.png")
            break
        case "Ayuda Social":
            imgDimension.image = UIImage(named:"BotonAyudaSocial.png")
            break
        case "Humana":
            imgDimension.image = UIImage(named:"BotonFamiliar.png")
            break
        case "Emprendimiento":
            imgDimension.image = UIImage(named:"BotonEmprendimiento.png")
            break
        case "Deportiva":
            imgDimension.image = UIImage(named:"BotonDeportiva.png")
            break
        case "Extra":
            imgDimension.image = UIImage(named:"BotonExtra.png")
            break
        default:
            break
        }
    }
    
    func setupTableView(){
        self.tableViewRecuerdos.delegate = self
        self.tableViewRecuerdos.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text  = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[indexPath.row].titulo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastRecuerdoIndexTap = indexPath.row
        self.tableViewRecuerdos.deselectRow(at: indexPath, animated: true)
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "RecuerdosToRecuerdosDetalles", sender: self)
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
