//
//  HijosConfigViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 28/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit
var lastDimensionConfigTap: Int!

class HijosConfigViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var textField_nombre: UITextField!
    @IBOutlet weak var textField_alias: UITextField!
    @IBOutlet weak var tableView_dimensiones: UITableView!
    @IBOutlet weak var btn_editar: UIBarButtonItem!
    
    var usernameTextField: UITextField?
    
    @IBAction func btnPressed_editar(_ sender: Any) {
        if (self.btn_editar.title == "Editar"){
            self.textField_nombre.isEnabled = true
            self.textField_alias.isEnabled = true
            self.btn_editar.title = "Ok"
        }else{
            self.btn_editar.title = "Editar"
            self.textField_nombre.isEnabled = false
            self.textField_alias.isEnabled = false
            
            userData.hijos[lastHijoConfigPersonTap].nombre = self.textField_nombre.text!
            userData.hijos[lastHijoConfigPersonTap].alias = self.textField_alias.text!
            
            
            let docDataUpdate: [String: Any] = [
                "nombre": self.textField_nombre.text!,
                "alias": self.textField_alias.text!
            ]
            
            db.collection("users").document(userData.uid).collection("hijos").document(userData.hijosref[lastHijoConfigPersonTap]).setData(docDataUpdate, merge: true)
            
            let alertController = UIAlertController(title: "Guardado", message: "Los datos se actualizaron correctamente", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
            })
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    @IBOutlet weak var btn_eliminar: UIButton!
    
    @IBAction func btnPressed_eliminar(_ sender: Any) {
        let database = LoadDataToFirestore()
        let alertController = UIAlertController(title: "¿Eliminar hijo " + userData.hijos[lastHijoConfigPersonTap].nombre + " ?", message: "Esta acción eliminara permanentemente toda su información incluyendo dimensiones y recuerdos, para continuar introduzca su nombre de usuario", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: self.usernameTextField)
        alertController.addAction(UIAlertAction(title: "Borrar", style: UIAlertAction.Style.destructive) { UIAlertAction in
            
            if (self.usernameTextField?.text == userData.nombre){
                let alertController2 = UIAlertController(title: "Borrando a " + userData.hijos[lastHijoConfigPersonTap].nombre , message: "Espere un momento porfavor", preferredStyle: UIAlertController.Style.alert)
                self.present(alertController2, animated: true, completion: nil)
                
                //obtengo todas las dimensiones del hijo
                db.collection("users").document(userData.uid).collection("hijos").document(userData.hijosref[lastHijoConfigPersonTap]).collection("dimensiones").getDocuments(){ (querySnapshot1, err) in
                    if err != nil {
                        print(err)
                    } else {
                        for document1 in querySnapshot1!.documents {
                            //elimino cada recuerdo de cada dimension
                            db.collection("users").document(userData.uid).collection("hijos").document(userData.hijosref[lastHijoConfigPersonTap]).collection("dimensiones").document(document1.documentID).collection("recuerdos").getDocuments(){ (querySnapshot2, err) in
                                if err != nil {
                                    print(err)
                                } else {
                                    for document2 in querySnapshot2!.documents{
                                        //si la dimension tiene recuerdos, aqui se elimina cada uno de los recuerdos
                                        db.collection("users").document(userData.uid).collection("hijos").document(userData.hijosref[lastHijoConfigPersonTap]).collection("dimensiones").document(document1.documentID).collection("recuerdos").document(document2.documentID).delete(){ err in
                                            if let err = err {
                                                print("Error removing document: \(err)")
                                            } else {
                                                print("Document successfully removed!")
                                            }
                                        }
                                    }
                                }
                                    
                                    //si no existen recuerdos en el snapshot entonces borro la dimension, aqui entra cuando se eliminar todos los recuerdos o cuando no tiene recuerdos la dimension
                                    db.collection("users").document(userData.uid).collection("hijos").document(userData.hijosref[lastHijoConfigPersonTap]).collection("dimensiones").document(document1.documentID).delete() { err in
                                        if let err = err {
                                            print("Error removing document: \(err)")
                                        } else {
                                            print("Document successfully removed!")
                                        }
                                    }
                                }
                            }
                            //aqui se elimina al hijo
                            db.collection("users").document(userData.uid).collection("hijos").document(userData.hijosref[lastHijoConfigPersonTap]).delete(){ err in
                                if let err = err {
                                    print("Error removing document: \(err)")
                                } else {
                                    print("Document successfully removed!")
                                    userData.hijos.remove(at: lastHijoConfigPersonTap)
                                    userData.hijosref.remove(at: lastHijoConfigPersonTap)
                                    database.eliminarReferenciaHijo()
                                    alertController2.dismiss(animated: true, completion: nil)
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        }
                    }
                
            }else{
                self.displayUsernameIncorrect()
            }
            
            
        })
        alertController.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default) { UIAlertAction in
            alertController.dismiss(animated: true, completion: nil)
        })
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.navigationItem.title = userData.hijos[lastHijoConfigPersonTap].nombre + " config."
        self.textField_nombre.text = userData.hijos[lastHijoConfigPersonTap].nombre
        self.textField_alias.text = userData.hijos[lastHijoConfigPersonTap].alias
        self.btn_eliminar.layer.cornerRadius = 5
        self.btn_eliminar.layer.borderWidth = 1
        self.btn_eliminar.layer.borderColor = UIColor.red.cgColor
        self.textField_alias.isEnabled = false
        self.textField_nombre.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.tableView_dimensiones.delegate = self
        self.tableView_dimensiones.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.hijos[lastHijoConfigPersonTap].dimensiones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell2")
        cell2.textLabel?.text  = userData.hijos[lastHijoConfigPersonTap].dimensiones[indexPath.row].nombre
        
        return cell2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastDimensionConfigTap = indexPath.row
        self.tableView_dimensiones.deselectRow(at: indexPath, animated: true)
       
        
    }
    
    func usernameTextField (textField: UITextField) -> Void{
        self.usernameTextField=textField
        textField.placeholder = "nombre de usuario"
    }
    
    func displayUsernameIncorrect() {
        let alertController3 = UIAlertController(title: "Nombre de usuario incorrecto", message: "La acción no se puede completar", preferredStyle: UIAlertController.Style.alert)
        alertController3.addAction(UIAlertAction(title: "Reintentar", style: UIAlertAction.Style.default) { UIAlertAction in
            self.btnPressed_eliminar(self)
        })
        alertController3.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default) { UIAlertAction in
        })
        self.present(alertController3, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        var title = ""
        var subtitle = ""
        if (userData.hijos[lastHijoConfigPersonTap].dimensiones.count == 1){
            title = "Hijo sin dimensiones"
            subtitle = "El hijo " + userData.hijos[lastHijoConfigPersonTap].nombre + " solo tiene la dimensión " + userData.hijos[lastHijoConfigPersonTap].dimensiones[indexPath.row].nombre + ", al eliminarla igualmente se eliminara toda la información del hijo. Introduzca su nombre de usuario para continuar"
        }else{
            title = "¿Eliminar dimensión " + userData.hijos[lastHijoConfigPersonTap].dimensiones[indexPath.row].nombre + "?"
            subtitle = "Está acción borrara permanentemente la dimensión y todos sus recuerdos contenidos"
        }
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: self.usernameTextField)

        alert.addAction(UIAlertAction(title: "Eliminar", style: UIAlertAction.Style.destructive, handler: {(ACTION) in alert.dismiss(animated: true, completion: nil)
            
            if editingStyle == .delete{
                if (userData.nombre == self.usernameTextField?.text){
                    self.deleteDimension(hijoID: userData.hijosref[lastHijoConfigPersonTap], dimensionID: userData.hijos[lastHijoConfigPersonTap].dimensionesref[indexPath.row], dimensionIndex: indexPath.row, hijoIndex: lastHijoConfigPersonTap, RecuerdosCount:userData.hijos[lastHijoConfigPersonTap].dimensiones[indexPath.row].recuerdos.count, indexPath: indexPath)
                }else{
                    let alertController5 = UIAlertController(title: "Nombre de usuario incorrecto", message: "La acción no se puede completar", preferredStyle: UIAlertController.Style.alert)
                    alertController5.addAction(UIAlertAction(title: "Reintentar", style: UIAlertAction.Style.default) { UIAlertAction in
                        self.tableView(tableView, commit: editingStyle, forRowAt: indexPath)
                    })
                    alertController5.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default) { UIAlertAction in
                    })
                    self.present(alertController5, animated: true, completion: nil)
                    
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: { (ACTION) in alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteDimension(hijoID: String, dimensionID: String, dimensionIndex: Int, hijoIndex:Int, RecuerdosCount:Int, indexPath: IndexPath){
        let database = LoadDataToFirestore()
        let alertController4 = UIAlertController(title: "Borrando dimensión " + userData.hijos[lastHijoConfigPersonTap].dimensiones[indexPath.row].nombre, message: "Espere un momento porfavor", preferredStyle: UIAlertController.Style.alert)
        self.present(alertController4, animated: true, completion: nil)
        
        //obtengo snapshot de todos los documentos de esa coleccion
        db.collection("users").document(userData.uid).collection("hijos").document(hijoID).collection("dimensiones").document(dimensionID).collection("recuerdos").getDocuments(){ (querySnapshot, err) in
            if err != nil {
                print(err)
            } else {
                var i = 0
                if (querySnapshot?.documents.count as! Int == 0){
                    if (userData.hijos[lastHijoConfigPersonTap].dimensiones.count == 1){
                        //alertController4.dismiss(animated: true, completion: nil)
                        self.lastDimensionAction(indexPath: indexPath, alertController: alertController4)
                    }else{
                        db.collection("users").document(userData.uid).collection("hijos").document(hijoID).collection("dimensiones").document(dimensionID).delete() { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                print("Document successfully removed!")
                                userData.hijos[hijoIndex].dimensionesref.remove(at: indexPath.row)
                                userData.hijos[lastHijoConfigPersonTap].dimensiones.remove(at: indexPath.row)
                                database.deleteReferenceDimension(hijoIndex:hijoIndex)
                                self.tableView_dimensiones.beginUpdates()
                                self.tableView_dimensiones.deleteRows(at: [indexPath], with: .fade)
                                self.tableView_dimensiones.endUpdates()
                                alertController4.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
                
                for document in querySnapshot!.documents {
                    //elimino cada documento de ese snapshot osea cada recuerdo
                    db.collection("users").document(userData.uid).collection("hijos").document(hijoID).collection("dimensiones").document(dimensionID).collection("recuerdos").document(document.documentID).delete(){ err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            i = i + 1
                            print("Document successfully removed!")
                            if (i == RecuerdosCount){
                                //elimino el documento que contiene a la coleccion borrada, es decir el doc con el nombre de la dimension
                                if (userData.hijos[lastHijoConfigPersonTap].dimensiones.count == 1){
                                    alertController4.dismiss(animated: true, completion: nil)
                                    self.lastDimensionAction(indexPath: indexPath, alertController: alertController4)
                                }else{
                                    db.collection("users").document(userData.uid).collection("hijos").document(hijoID).collection("dimensiones").document(dimensionID).delete() { err in
                                        if let err = err {
                                            print("Error removing document: \(err)")
                                        } else {
                                            print("Document successfully removed!")
                                            userData.hijos[hijoIndex].dimensionesref.remove(at: indexPath.row)
                                            userData.hijos[lastHijoConfigPersonTap].dimensiones.remove(at: indexPath.row)
                                            database.deleteReferenceDimension(hijoIndex:hijoIndex)
                                            self.tableView_dimensiones.beginUpdates()
                                            self.tableView_dimensiones.deleteRows(at: [indexPath], with: .fade)
                                            self.tableView_dimensiones.endUpdates()
                                            alertController4.dismiss(animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func lastDimensionAction(indexPath: IndexPath, alertController: UIAlertController) {
        let dbtemp = LoadDataToFirestore()
        db.collection("users").document(userData.uid).collection("hijos").document(userData.hijosref[lastHijoConfigPersonTap]).collection("dimensiones").document(userData.hijos[lastHijoConfigPersonTap].dimensionesref[indexPath.row]).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                db.collection("users").document(userData.uid).collection("hijos").document(userData.hijosref[lastHijoConfigPersonTap]).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                        userData.hijos.remove(at: lastHijoConfigPersonTap)
                        userData.hijosref.remove(at: lastHijoConfigPersonTap)
                        dbtemp.eliminarReferenciaHijo()
                        /*self.tableView_dimensiones.beginUpdates()
                        self.tableView_dimensiones.deleteRows(at: [indexPath], with: .fade)
                        self.tableView_dimensiones.endUpdates()*/
                        alertController.dismiss(animated: true, completion: nil)
                        self.navigationController?.popViewController(animated: true)
                        
                    }
                }
            }
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

